import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { v4 as uuidv4 } from 'uuid';

import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  static targets = [ "chart" ]
  
  initialize() {
    this.EmployeeChannel = null;
    this.channel_id = uuidv4();
    this.consumer = createConsumer();
  }

  createChart(employee_data){
    const labels = []
    const employee_count_data = []
    
    employee_data.classificated_salaries.forEach((element) => {
      labels.push(`De ${element.min_range} a ${element.max_range}`)
      employee_count_data.push(element.employees_count)
    });

    labels.push(`Acima de ${employee_data.classificated_salaries[employee_data.classificated_salaries.length - 1].max_range}`)
    employee_count_data.push(employee_data.out_of_range_classificated_salaries.employees_count)

    const data = {
      labels: labels,
      datasets: [{
        data: employee_count_data,
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(153, 102, 255)',
        ],
        hoverOffset: 4
      }]
    };

    const config = {
      type: 'doughnut',
      data: data,
    };

    new Chart(this.chartTarget, config);
  }

  connect() {
    this.EmployeeChannel = this.createChanel(this)
  }

  disconnect() {
    this.EmployeeChannel.unsubscribe();
  }

  createChanel() {
    const root = this;
    return this.consumer.subscriptions.create({ channel: "Employees::EmployeesByCategoryChannel", channel_id: this.channel_id }, {
      connected() {
        this.perform('fetch_employees_by_category', { channel_id: root.channel_id });
      },
      received(data) {
        root.createChart(data)
      },
      disconnected() {
      },
    })
  }
}