var ctx = document.getElementById('myChart').getContext('2d');
var earning = document.getElementById('earning').getContext('2d');

var myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: ['Cage1', 'Cage2', 'Cage3', 'Cage4', 'Cage5', 'Cage6', 'Cage7', 'Cage8', 'Cage9', 'Cage10','Cage11'],
        datasets: [{
                label: 'Traffic Source',
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(37 ,35 ,35, 1)',
                    'rgba(	198, 159, 128, 1)',
                    'rgb(255,153,71, 1)',
                    'rgb(231, 30 ,30 ,1)',
                    '#e15759',
                    '#59a14f'
                ],
            }]
    },
    options: {
        responsive: true,
    }
});
var myChart = new Chart(earning, {
    type: 'bar',
    data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'June', 'July', 'August', 'Semptember', 'October', 'November', 'December'],
        datasets: [{
                label: 'Earning',
                data: dataEarning,
                backgroundColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
            }]
    },
    options: {
        responsive: true,
    }
});