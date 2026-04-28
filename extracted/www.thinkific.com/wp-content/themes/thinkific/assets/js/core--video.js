document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".wp-block-video").forEach(e => {
        const t = e.querySelector("video");
        if (!t) return;
        if (e.querySelector(".video-player-overlay")) return;
        e.style.position = "relative";
        const i = e => {
                if (e.getAttribute("aria-label")) return e.getAttribute("aria-label");
                if (e.getAttribute("title")) return e.getAttribute("title");
                const t = e.closest("figure");
                if (t) {
                    const e = t.querySelector("figcaption");
                    if (e && e.innerText.trim()) return e.innerText.trim()
                }
                const i = e.currentSrc || e.src;
                return i ? i.split("/").pop().split("?")[0] : "Unknown Title"
            },
            r = e => {
                window.dataLayer = window.dataLayer || [], window.dataLayer.push(e)
            },
            o = document.createElement("div");
        o.classList.add("video-player-overlay");
        const n = document.createElement("button");
        n.classList.add("video-player-btn"), n.setAttribute("aria-label", "Play video"), n.innerHTML = '\n            <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">\n                <path d="M8 5v14l11-7z"/>\n            </svg>\n        ', o.appendChild(n), e.appendChild(o), t.hasAttribute("autoplay") && (o.style.display = "none");
        const d = t.controls;
        t.controls = !1;
        const a = () => {
            o.style.display = "none", d && (t.controls = !0), t.play()
        };
        n.addEventListener("click", e => {
            e.stopPropagation(), a()
        }), o.addEventListener("click", a);
        let s = !1;
        const l = {
            25: !1,
            50: !1,
            75: !1,
            100: !1
        };
        t.addEventListener("play", () => {
            o.style.display = "none", d && (t.controls = !0), s || (s = !0, r({
                event: "video_interaction",
                event_type: "start",
                "gtm.videoStatus": "start",
                "gtm.videoCurrentTime": 0,
                "gtm.videoDuration": Math.round(t.duration || 0),
                "gtm.VideoPercent": 0,
                "gtm.videoProvider": "Wordpress Block",
                "gtm.videoTitle": i(t),
                "gtm.videoUrl": t.currentSrc || t.src,
                "gtm.videoVisible": !0
            }))
        }), t.addEventListener("timeupdate", () => {
            if (!t.duration) return;
            const e = t.currentTime / t.duration * 100,
                o = Math.round(t.currentTime),
                n = Math.round(t.duration),
                d = i(t),
                a = t.currentSrc || t.src,
                s = e => {
                    r({
                        event: "video_interaction",
                        event_type: "progress",
                        "gtm.videoStatus": "progress",
                        "gtm.videoCurrentTime": o,
                        "gtm.videoDuration": n,
                        "gtm.VideoPercent": e,
                        "gtm.videoProvider": "Wordpress Block",
                        "gtm.videoTitle": d,
                        "gtm.videoUrl": a,
                        "gtm.videoVisible": !0
                    })
                };
            e >= 25 && !l[25] && (s(25), l[25] = !0), e >= 50 && !l[50] && (s(50), l[50] = !0), e >= 75 && !l[75] && (s(75), l[75] = !0), e >= 99 && !l[100] && (r({
                event: "video_interaction",
                event_type: "complete",
                "gtm.videoStatus": "complete",
                "gtm.videoCurrentTime": n,
                "gtm.videoDuration": n,
                "gtm.VideoPercent": 100,
                "gtm.videoProvider": "Wordpress Block",
                "gtm.videoTitle": d,
                "gtm.videoUrl": a,
                "gtm.videoVisible": !0
            }), l[100] = !0)
        }), t.addEventListener("ended", () => {
            if (!l[100]) {
                const e = Math.round(t.duration || 0);
                r({
                    event: "video_interaction",
                    event_type: "complete",
                    "gtm.videoStatus": "complete",
                    "gtm.videoCurrentTime": e,
                    "gtm.videoDuration": e,
                    "gtm.VideoPercent": 100,
                    "gtm.videoProvider": "Wordpress Block",
                    "gtm.videoTitle": i(t),
                    "gtm.videoUrl": t.currentSrc || t.src,
                    "gtm.videoVisible": !0
                }), l[100] = !0
            }
        }), t.addEventListener("waiting", () => {
            if (t.currentTime > .1) {
                const e = Math.round(t.duration);
                r({
                    event: "video_interaction",
                    event_type: "buffering",
                    "gtm.videoStatus": "progress",
                    "gtm.videoCurrentTime": e,
                    "gtm.videoDuration": e,
                    "gtm.VideoPercent": 100,
                    "gtm.videoProvider": "Wordpress Block",
                    "gtm.videoTitle": i(t),
                    "gtm.videoUrl": t.currentSrc || t.src,
                    "gtm.videoVisible": !0
                })
            }
        })
    })
});