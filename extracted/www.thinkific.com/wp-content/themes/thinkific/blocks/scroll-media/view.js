jQuery(document).ready(t => {
    t(".thinkific-scroll-media-container").each(function() {
        const e = t(this),
            i = e.find(".thinkific-scroll-media-track").find(".thinkific-scroll-media-row-wrapper"),
            s = e.find(".thinkific-scroll-media-sticky-item"),
            n = (e.find(".thinkific-scroll-media-sticky"), e.hasClass("is-locked-to-side"));

        function a() {
            n || document.querySelectorAll(".thinkific-scroll-media-sticky").forEach(t => {
                const e = t.querySelectorAll(".thinkific-scroll-media-sticky-content.active");
                let i = null;
                if (e.forEach(t => {
                        "none" !== window.getComputedStyle(t).display && !i && (i = t)
                    }), !i) return;
                const s = i.offsetHeight,
                    n = (window.innerHeight - s) / 2;
                t.style.top = `${n}px`
            })
        }
        window.addEventListener("load", () => {
            a(),
                function() {
                    if (n) return;
                    const t = document.querySelector(".thinkific-scroll-media-sticky-box");
                    t && new MutationObserver(t => {
                        let e = !1;
                        for (const i of t) "attributes" === i.type && "class" === i.attributeName && i.target.classList.contains("thinkific-scroll-media-sticky-content") && (e = !0);
                        e && a()
                    }).observe(t, {
                        subtree: !0,
                        attributes: !0,
                        attributeFilter: ["class"]
                    })
                }()
        }), window.addEventListener("resize", a);
        const c = () => {
            if (n) return;
            const a = t(window).scrollTop() + window.innerHeight / 2;
            let c = null,
                o = 1 / 0;
            i.each((e, i) => {
                const s = t(i),
                    n = s.offset().top + s.outerHeight() / 2,
                    l = Math.abs(a - n);
                l < o && (o = l, c = s)
            }), (t => {
                if (n) return;
                const i = s.filter(`[data-index="${t}"]`);
                if (!i.length || i.hasClass("active")) return;
                const a = e.hasClass("fadeIn");
                s.filter(".active").removeClass("active").hide(0), a ? i.fadeIn(150).addClass("active") : i.show().addClass("active")
            })(c ? c.data("index") : i.first().data("index"))
        };
        if (n) s.show().addClass("active");
        else {
            const e = s.filter(".active");
            s.hide().removeClass("active"), e.length ? e.show().addClass("active") : s.first().show().addClass("active"), t(window).on("scroll resize", () => {
                c()
            }), c()
        }
    })
});