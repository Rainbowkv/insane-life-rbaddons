let currentAudio = null;
let isPlaying = false;

function stopMusic(){
    if (currentAudio) {
        currentAudio.pause();
        currentAudio = null;
        isPlaying = false;
    }
}

window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === 'play') {
        // 若已播放其他音乐，则先停止
        if (currentAudio) {
            stopMusic()
        }
        // 播放新音乐
        currentAudio = new Audio(data.url);
        currentAudio.loop = true;
        currentAudio.volume = data.volume;
        currentAudio.addEventListener('canplay', function () {
            if (isPlaying) return;

            try {
                if (typeof data.offset === 'number' && !isNaN(data.offset)) {
                    // console.log("set offset:", data.offset);
                    currentAudio.currentTime = data.offset;
                }

                setTimeout(() => {
                    currentAudio.play().then(() => {
                        // console.log("success");
                        isPlaying = true;
                    }).catch((err) => {
                        console.warn("error:", err);
                    });
                }, 10); // 延迟一帧，防止立即中断
            } catch (err) {
                console.error("set error:", err);
            }
        }, { once: true });

        currentAudio.addEventListener('error', (e) => {
            console.error("load error", e);
        });
    }

    if (data.action === 'stop') {
        if (currentAudio) {
            stopMusic()
        }
    }

    if (data.action === 'setVolume') {
        if (currentAudio) {
            currentAudio.volume = data.volume;
        }
    }
});