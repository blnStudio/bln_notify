new Vue({
    el: "#app",
    data: function () {
      return {
        positions: [
          "top-right",
          "top-center",
          "top-left",
          "middle-right",
          "middle-center",
          "middle-left",
          "bottom-right",
          "bottom-center",
          "bottom-left",
        ],
        selectedPosition: "top-right",
        notificationContainers: {},
        notificationCount: 0,
        useBackground: true,
        contentAlignment: "start",
        isRTL: false,
      };
    },
    created: function () {
      this.positions.forEach((position) => {
        this.$set(this.notificationContainers, position, []);
      });

      window.addEventListener('message', (event) => {
        if (event.data.type === 'BLN_NOTIFY') {            
          this.PlaySound(event.data.options?.customSound);
          this.notify(event.data.options);
        }else if (event.data.type === 'BLN_NOTIFY_KEY_PRESSED') {
          this.handleKeyPress(event.data.notificationId, event.data.key);
      }
      });
    },
    methods: {
      notify: function (options) {        
        var id = this.notificationCount++;
          var duration = options.duration || 5000;
          
          const notification = {
            id: id,
            title: options.title || "Notification",
            description: options.description || null,
            icon: options.icon || null,
            useBackground: options.useBackground !== undefined ? options.useBackground : this.useBackground,
            contentAlignment: options.contentAlignment || this.contentAlignment,
            isRTL: options.isRTL !== undefined ? options.isRTL : this.isRTL,
            duration: duration,
            remainingTime: duration / 1000,
            progress: {
              enabled: options.progress?.enabled ?? false,
              type: options.progress?.type || 'bar',
              color: options.progress?.color || '#fff',
              value: 1
            },
            keyActions: options.keyActions || {}
          };


          const placement = options.placement || this.selectedPosition;
          this.$set(this.notificationContainers, placement, [
            notification,
            ...this.notificationContainers[placement]
          ]);

          if (notification.progress.enabled) {
            requestAnimationFrame(() => {
              requestAnimationFrame(() => {
                notification.progress.value = 0;
              });
            });
            if (notification.progress.type === 'circle') {
              const startTime = Date.now();
              const interval = setInterval(() => {
                const elapsed = Date.now() - startTime;
                notification.remainingTime = Math.max(0, (duration - elapsed) / 1000);
                
                if (elapsed >= duration) {
                  clearInterval(interval);
                }
              }, 100);
            }
          }
          setTimeout(() => {
            this.removeNotification(placement, id);
          }, duration);
      },
      removeNotification: function (position, id) {

        var index = this.notificationContainers[position].findIndex(n => n.id === id);
        if (index !== -1) {
          this.notificationContainers[position].splice(index, 1);
        }
        this.PlaySound();
      },
      getIconUrl: function (icon) {
        if (icon.includes('//')) {
          return icon;
        }
        return `./assets/imgs/icons/${icon}.png`;
      },
      PlaySound(soundData) {
        fetch(`https://${GetParentResourceName()}/playSound`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(soundData || {}),
        });
      },
      handleKeyPress: function(notificationId, key) {
        for (const position in this.notificationContainers) {
            const notification = this.notificationContainers[position].find(n => n.id === notificationId);
            if (notification) {
                this.$emit('notification-key-pressed', { notificationId, key });
                break;
            }
        }
    }
    },
  });