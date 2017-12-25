


//投标进度条
function customizeHighcharts(params) {
    var defaultParams = {
        colors: ['#fac83e', '#eee'],
        tooltip: {
            shadow: false,
            animation: false,
            hideDelay: 40
        },
        title: {
            align: 'left',
            style: {
                color: '#000000',
                font: 'normal 16px "Microsoft YaHei", "Lucida Sans Unicode", "Myriad Pro", "Hiragino Sans GB", "Heiti SC", Verdana, simsun'
            }
        },
        chart: {
            borderRadius: 0,
            borderWidth: 0
        },
        credits: {
            enabled: false
        }
    };

    Highcharts.setOptions($.extend(defaultParams, params));
}

function initDistribution(report, hostId, title) {
    total = _.reduce(_.pluck(report, 'data'), function (total, d) {
        return total + d;
    }, 0)

    report = _.map(report, function (r) {
        percent = (r.data / total * 100).toPrecision(4);
        return {
            name: r.label,
            y: +percent
        };
    });

    $('.' + hostId).highcharts({
        chart: {
            type: 'pie'
        },
        title: null,
        yAxis: {
            title: {
                text: 'yaxis'
            }
        },
        plotOptions: {
            pie: {
                share: false,
                center: ['50%', '50%'],
                dataLabels: {
                    enabled: false
                },
                showInLegend: false
            }
        },
        legend: {
            enabled: false,
            layout: 'vertical',
            align: 'right',
            width: 300,
            verticalAlign: 'middle',
            userHTML: true,
            borderColor: 'transparent',
            labelFormatter: function () {
                return '<div>' + this.name + '</div>';
            }
        },
        tooltip: {
            formatter: function () {
                return this.key + ':' + this.y + '%';
            }
        },
        series: [{
            size: '140%',
            innerSize: '50%',
            data: report
        }]
    });
}


function initDistribution_small(report, hostId, title) {
    total = _.reduce(_.pluck(report, 'data'), function (total, d) {
        return total + d;
    }, 0)

    report = _.map(report, function (r) {
        percent = (r.data / total * 100).toPrecision(4);
        return {
            name: r.label,
            y: +percent
        };
    });

    $('.' + hostId).highcharts({
        chart: {
            type: 'pie'
        },
        title: null,
        yAxis: {
            title: {
                text: 'yaxis'
            }
        },
        plotOptions: {
            pie: {
                share: false,
                center: ['50%', '50%'],
                dataLabels: {
                    enabled: false
                },
                showInLegend: false
            }
        },
        legend: {
            enabled: false,
            layout: 'vertical',
            align: 'right',
            width: 300,
            verticalAlign: 'middle',
            userHTML: true,
            borderColor: 'transparent',
            labelFormatter: function () {
                return '<div>' + this.name + '</div>';
            }
        },
        tooltip: {
            formatter: function () {
                return this.key + ':' + this.y + '%';
            }
        },
        series: [{
            size: '50%',
            innerSize: '140%',
            data: report
        }]
    });
}




