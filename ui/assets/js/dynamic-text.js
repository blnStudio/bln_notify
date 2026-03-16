Vue.component('dynamic-text', {
    props: {
        text: {
            type: String,
            required: true
        },
        resourceName: {
            type: String,
            required: true
        },
        notificationId: {
            required: true
        }
    },
    data() {
        return {
            activeKeys: new Set()
        }
    },
    methods: {
        isValidFontSize(size) {
            if (!size) return false;
            return /^-?\d*\.?\d+(px|em|rem|%|pt|vh|vw|vmin|vmax|ch|ex)$/i.test(size.trim());
        },
        isValidFontWeight(weight) {
            if (!weight) return false;
            const normalized = weight.trim().toLowerCase();
            if (/^[1-9]00$/.test(normalized)) return true;
            return ['normal', 'bold', 'bolder', 'lighter'].includes(normalized);
        },
        parseText() {
            const parts = [];
            let currentText = '';
            let currentColor = null;
            let currentSize = null;
            let currentWeight = null;
            let i = 0;

            const pushCurrentText = () => {
                if (currentText) {
                    parts.push({
                        type: 'text',
                        text: currentText,
                        color: currentColor,
                        size: currentSize,
                        weight: currentWeight
                    });
                    currentText = '';
                }
            };

            while (i < this.text.length) {
                if (this.text[i] === '~') {
                    pushCurrentText();

                    const endTilde = this.text.indexOf('~', i + 1);
                    if (endTilde === -1) {
                        currentText += '~';
                        i++;
                        continue;
                    }

                    const code = this.text.substring(i + 1, endTilde);

                    if (code.startsWith('key:')) {
                        const keyData = code.substring(4);
                        const [keyName, keyImage] = keyData.split(':');
                        parts.push({
                            type: 'key',
                            key: keyName.toUpperCase(),
                            image: keyImage || null
                        });
                    } else if (code === 'e') {
                        currentColor = null;
                        currentSize = null;
                        currentWeight = null;
                    } else if (code.startsWith('size:')) {
                        const sizeData = code.substring(5);
                        const [rawSize, rawWeight] = sizeData.split('|');
                        const nextSize = rawSize ? rawSize.trim() : null;
                        const nextWeight = rawWeight ? rawWeight.trim() : null;

                        if (nextSize && this.isValidFontSize(nextSize)) {
                            currentSize = nextSize;
                        }

                        if (nextWeight && this.isValidFontWeight(nextWeight)) {
                            currentWeight = nextWeight;
                        } else {
                            currentWeight = null;
                        }
                    } else if (code.startsWith('#')) {
                        currentColor = code;
                    } else if (code.startsWith('img:')) {
                        const imageData = code.substring(4);
                        parts.push({ type: 'image', src: this.getImageUrl(imageData) });
                    } else {
                        currentColor = code;
                    }

                    i = endTilde + 1;
                } else {
                    currentText += this.text[i];
                    i++;
                }
            }

            pushCurrentText();
            return parts;
        },
        getImageUrl(image) {
            if (image.includes('//')) {
                return image;
            }
            return `./assets/imgs/icons/${image}.png`;
        },
        emitKeyPress(key) {
            this.$root.$emit('notification-key-pressed', {
                notificationId: this.notificationId,
                key: key
            });
        }
    },
    mounted() {
        const keyHandlers = new Map();

        this.parseText().forEach(part => {
            if (part.type === 'key') {
                const handler = (e) => {
                    if (e.key.toUpperCase() === part.key.toUpperCase()) {
                        this.activeKeys.add(part.key);
                        this.emitKeyPress(part.key);
                        setTimeout(() => {
                            this.activeKeys.delete(part.key);
                        }, 200);
                    }
                };
                keyHandlers.set(part.key, handler);
                window.addEventListener('keydown', handler);
            }
        });

        this.$once('hook:beforeDestroy', () => {
            keyHandlers.forEach((handler, key) => {
                window.removeEventListener('keydown', handler);
            });
        });
    },
    render(h) {
        const parts = this.parseText();
        return h('span', {}, parts.map((part, index) => {
            if (part.type === 'key') {
                return h('span', {
                    key: index,
                    class: ['key-icon', { 'key-active': this.activeKeys.has(part.key) }]
                }, [
                    part.image
                        ? h('img', { attrs: { src: this.getImageUrl(part.image) } })
                        : part.key
                ]);
            } else if (part.type === 'image') {
                return h('img', {
                    key: index,
                    class: 'inline-image',
                    attrs: {
                        src: part.src,
                        height: '20px'
                    }
                });
            } else {
                return h('span', {
                    key: index,
                    style: {
                        color: part.color,
                        fontSize: part.size,
                        fontWeight: part.weight
                    }
                }, part.text);
            }
        }));
    }
});