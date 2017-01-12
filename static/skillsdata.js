var skillsdata;


skillsdata = {
  "All": {
    "Appartment": [0],
    "Car": [0],
    "Сlothing": [0],
    "Entertainment": [0],
    "Food&Drinks": [0],
    "Other": [0],
    "Salary": [0],
    "Travel": [0]
}
};

var data = {};
function build_data(app) {

    app.gridData.sort(date_sort);


    for (var i = 0; i < app.gridData.length; ++i){
        if (app.gridData[i].kind == '-'){
            var d = app.gridData[i].date.substr(3);
            if (!data.hasOwnProperty(d))
            {
                data[d] = {"Appartment":0, "Car":0, "Сlothing":0, "Entertainment":0, "Food&Drinks":0, "Other":0, "Salary":0, "Travel":0};
            }
                data[d][app.gridData[i].theme] += app.gridData[i].cost;
        }
    }

    var sorted_data = Object.keys(data).sort(function (a,b) {
        a = a.split('/').reverse().join('');
        b = b.split('/').reverse().join('');
        return (a > b ? 1 : a < b ? -1 : 0);
    });
    for (var i = 0; i < sorted_data.length; ++i){
        var d = sorted_data[i];
        for (var key in data[d]) {
            skillsdata.All[key].push(data[d][key]);
        }
    }
    main();
}


function date_sort(a,b) {
    a = a.date.split('/').reverse().join('');
    b = b.date.split('/').reverse().join('');
    return (a > b ? 1 : a < b ? -1 : 0);
}
