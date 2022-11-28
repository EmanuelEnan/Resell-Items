const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const employeeSchema = new Schema({
    userId: { type: String },
    image: { type: String },
    content: { type: String },
    title: { type: String },
    price: {type: String},
    date: { type: Date, default: Date.now }
});

const Employee = mongoose.model('employee', employeeSchema);

module.exports = Employee;