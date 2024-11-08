import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { v4 as uuidv4 } from 'uuid';
import { NumberInput } from "controllers/utils/number_input"
import Inputmask from 'inputmask'

export default class extends Controller {
  static targets = ["baseSalary", "salaryDiscount", "idDocument"]

  initialize() {
    Object.assign(this, NumberInput);
    this.EmployeeChannel = null;
    this.channel_id = uuidv4();
    this.consumer = createConsumer();
    this.set_number_input(this.baseSalaryTarget, 'currency');
    this.set_number_input(this.salaryDiscountTarget, 'currency');
    this.mask_cpf().mask(this.idDocumentTarget);
  }

  connect() {
    this.EmployeeChannel = this.createChanel(this)
    this.baseSalaryTarget.addEventListener("change", this.baseSalaryChanged.bind(this))
  }

  disconnect() {
    this.EmployeeChannel.unsubscribe();
  }


  mask_cpf() {
    return new Inputmask.default(
      {
        mask: '999.999.999-99',
        greedy: false,
        removeMaskOnSubmit: true,
      }  
    )
  }

  baseSalaryChanged() {
    this.EmployeeChannel.perform("calculate_salary_discount", {
      base_salary: this.baseSalaryTarget.value
    })
  }

  createChanel() {
    const root = this;
    return this.consumer.subscriptions.create({ channel: "Employees::CalculateSalaryDiscountChannel", channel_id: this.channel_id }, {
      connected() {
      },
      received(data) {
        root.salaryDiscountTarget.value = data.salary_discount;
      },
      disconnected() {
      },
    })
  }
}
