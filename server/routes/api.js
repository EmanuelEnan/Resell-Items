const express = require('express');
const Employee = require('../models/employee');
const router = express.Router();


// router.get('/employee', (req, res) =>
//     res.send({ type: 'get DATA', country: 'BD', name: 'son', }));

router.get('/employee/new', async function (req, res) {
    const newEmp = new Employee(
        {
            userId: '0006',
            image: '',
            content: 'pic',
            title: 'pk'
        },


    );
    await newEmp.save();

    const response = { message: 'new employe produced!' };
    res.json(response);
});

// router.get('/employee/:userId', (req, res, next) =>
//     Employee.find({ userId: req.params.userId }).then((employees) =>
//         res.send(employees)
//     ).catch(next)
// );
router.get('/employee/create', (req, res, next) =>
    Employee.find().then((employees) =>
        res.send(employees)
    ).catch(next)
);

router.post('/employee/delete', async function (req, res) {
    await Employee.deleteOne({ userId: req.body.userId });

    const response = { message: 'note deleted!' + `id: ${req.body.userId}` };
    res.json(response);
});

router.post('/employee', (req, res) => {
    const post = new Employee({
        userId: req.body.userId,
        image: req.body.image,
        content: req.body.content,
        title: req.body.title,
        price: req.body.price,
    });
    post.save().then(data => {
        res.json(data);
    }).catch(err => {
        res.json({ message: err });
    });
});
module.exports = router;