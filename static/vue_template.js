Vue.component('demo-grid', {
  template: '#grid-template',
  props: {
    data: Array,
    columns: Array,
    filterKey: String,
    icons: Object,
    total: Number
  },
  data: function () {
    var sortOrders = {}
    this.columns.forEach(function (key) {
      sortOrders[key] = 1
    })
    return {
      sortKey: '',
      sortOrders: sortOrders
    }
  },
  computed: {
    filteredData: function () {
      var sortKey = this.sortKey
      var filterKey = this.filterKey && this.filterKey.toLowerCase()
      var order = this.sortOrders[sortKey] || 1
      var data = this.data
      if (filterKey) {
        data = data.filter(function (row) {
          return Object.keys(row).some(function (key) {
            return String(row[key]).toLowerCase().indexOf(filterKey) > -1
          })
        })
      }
      if (sortKey) {
        data = data.slice().sort(function (a, b) {
          a = a[sortKey]
          b = b[sortKey]
          return (a === b ? 0 : a > b ? 1 : -1) * order
        })
      }
      if (sortKey == "date"){
          data = data.slice().sort(function(a,b) {
              a = a[sortKey];
              b = b[sortKey];
              a = a.split('/').reverse().join('');
              b = b.split('/').reverse().join('');
              return (a > b ? 1 : a < b ? -1 : 0)* order;
            })
      }
      return data
    }
  },
  filters: {
    capitalize: function (str) {
      return str.charAt(0).toUpperCase() + str.slice(1)
    }
  },
  methods: {
    sortBy: function (key) {
      this.sortKey = key
      this.sortOrders[key] = this.sortOrders[key] * -1
    }
  }
})

// bootstrap the demo
var app;

window.onload = function () {
    app = new Vue({
      el: '#demo',
      data: {
        total : 0,
        searchQuery: '',
        gridColumns: ['kind', 'theme', 'item', 'cost', 'date'],
        gridIcons: {
            kind: "glyphicon-stats",
            theme: "glyphicon-home",
            item: "glyphicon-shopping-cart",
            cost: "glyphicon-usd",
            date: "glyphicon-calendar"
        },
        gridData: [
        //   { type: '+', theme: 'Shop', item: "none", cost: 100.00, date: '12.08.2016'},
        ]
      }
    });

    $.post("/show", {}, 'json').done (data => {
            app.gridData = data;
            for (var i = 0; i < app.gridData.length; ++i)
                if (app.gridData[i].kind == "-")
                    app.total -= app.gridData[i].cost;
                else app.total += app.gridData[i].cost;
            build_data(app);
        });


}
