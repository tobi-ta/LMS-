(() => {
    const e = document.querySelector(".shimmer"),
        t = document.querySelector(".hero-stacked-images");
    if (!e && !t) return;
    let s = !1;
    const r = e || t,
        c = new IntersectionObserver(r => {
            r.forEach(r => {
                r.isIntersecting && (s || (s = !0, setTimeout(() => {
                    t && t.classList.add("hero-images-active"), e && setTimeout(() => {
                        e.classList.add("shimmer-active")
                    }, 1900)
                }, 500)), c.disconnect())
            })
        }, {
            threshold: .2
        });
    c.observe(r)
})();