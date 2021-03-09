// Draw the chart and set the chart values
export function drawChart() {
  let canvas = document.getElementById("pieChart");
  let ctx = canvas.getContext('2d');
  
  // Global Options:
  Chart.defaults.global.defaultFontColor = 'black';
  Chart.defaults.global.defaultFontSize = 16;
  
  const value_ai = document.getElementById('percentage_amount_ai').value
  const value_jr = document.getElementById('percentage_amount_jr').value
  const value_sz = document.getElementById('percentage_amount_sz').value
  console.log({value_ai, value_jr, value_sz})
  const data = {
      labels: ["A-I", "J-R", "S-Z"],
      datasets: [
        {
            fill: true,
            backgroundColor: [
                'black',
                'white',
                'grey'
            ],
            data: [Number(value_ai), Number(value_jr), Number(value_sz)],
            // data: [12, 12, 12],  
            borderColor:	['black', 'black', 'black'],
            borderWidth: [2, 2, 2]
        }
    ]
  };

  let options = {
    title: {
              display: true,
              text: 'Quality Percentage',
              position: 'bottom'
          },
    responsive: true,
    maintainAspectRation: false,
    aspectRatio: 2,
    rotation: -0.7 * Math.PI,
    animation: {
      animateScale: false
    },
    layout: {
      padding: {
        // right: 400
      }
    }
  };

  new Chart(ctx, {
    type: 'pie',
    data: data,
    options: options
  });
}
