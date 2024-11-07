import Inputmask from 'inputmask'

const ALIASES = {
  numeric: {
    alias: 'numeric',
    groupSeparator: '.',
    radixPoint: ',',
    digits: 2,
    digitsOptional: false,
    autoGroup: true,
    autoUnmask: true,
    removeMaskOnSubmit: true,
    unmaskAsNumber: true,
    allowMinus: false,
    rightAlign: false,
  },
  currency: {
    alias: 'currency',
    groupSeparator: '.',
    radixPoint: ',',
    digits: 2,
    digitsOptional: false,
    autoGroup: true,
    autoUnmask: true,
    removeMaskOnSubmit: true,
    unmaskAsNumber: true,
    allowMinus: false,
    rightAlign: false,
    prefix: 'R$ ',
    placeholder: '0,00',
  },
  decimal: {
    alias: 'decimal',
    groupSeparator: '.',
    radixPoint: ',',
    digits: 2,
    digitsOptional: false,
    autoGroup: true,
    autoUnmask: true,
    removeMaskOnSubmit: true,
    unmaskAsNumber: true,
    allowMinus: false,
    rightAlign: false,
    placeholder: '0,00',
  },
  integer: {
    alias: 'integer',
    groupSeparator: '.',
    radixPoint: ',',
    removeMaskOnSubmit: true,
    allowMinus: false,
    placeholder: '0',
    // digitsOptional: false,
    // autoUnmask: false,
    // digits: 0,
    // autoGroup: true,
    // unmaskAsNumber: true,
    // rightAlign: false,
  },
  percentage: {
    alias: 'percentage',
    groupSeparator: '.',
    radixPoint: ',',
    digits: 2,
    digitsOptional: false,
    autoGroup: true,
    autoUnmask: true,
    removeMaskOnSubmit: true,
    unmaskAsNumber: true,
    allowMinus: false,
    rightAlign: false,
    suffix: '%',
    placeholder: '0,00',
  },
}

export const NumberInput = {

  set_number_input(input, alias='numeric') {
    this.set_number_input_mask(input, alias)
  },
  set_number_input_mask(input, alias) {
    this.mask_number_format(alias).mask(input)
  },
  mask_number_format(alias) {
    return new Inputmask.default(ALIASES[alias])
  },
  get_input_unmasked_value(input) {
    if (input.inputmask) {
      return parseFloat(input.inputmask.unmaskedvalue().replace(',', '.'))
    } else {
      return parseFloat(input.value)
    }
  },
}
