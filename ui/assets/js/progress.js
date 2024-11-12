Vue.component('circle-progress', {
    props: {
      progress: Number,
      duration: Number,
      color: String,
      remainingTime: Number
    },
    computed: {
      radius() {
        return 18;
      },
      circumference() {
        return 2 * Math.PI * this.radius;
      },
      strokeDashoffset() {
        return this.circumference * (1 - this.progress);
      }
    },
    template: `
      <div class="progress-circle">
        <svg viewBox="0 0 40 40">
          <circle class="progress-circle-bg"
            cx="20" cy="20" 
            :r="radius"
          />
          <circle
            cx="20" cy="20" 
            :r="radius"
            :stroke="color"
            fill="none"
            stroke-width="3"
            stroke-linecap="round"
            :stroke-dasharray="circumference"
            :stroke-dashoffset="strokeDashoffset"
            style="transform: rotate(-90deg); transform-origin: center;"
            :style="{ 
              transition: 'stroke-dashoffset ' + duration + 'ms linear',
              stroke: color // Add direct color binding here
            }"
          />
          <text x="20" y="20" class="progress-circle-text">
            {{Math.ceil(remainingTime)}}
          </text>
        </svg>
      </div>
    `
  });

  Vue.component('bar-progress', {
    props: {
      progress: Number,
      duration: Number,
      color: String
    },
    template: `
      <div class="progress-bar">
        <div class="progress-bar-fill" 
          :style="{
            backgroundColor: color,
            transform: \`scaleX(\${progress})\`,
            transition: \`transform \${duration}ms linear\`
          }"
        ></div>
      </div>
    `
  });