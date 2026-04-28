(() => {
    var e = {
            5915() {
                document.querySelectorAll("footer nav a").forEach(function(e) {
                    e.addEventListener("click", function() {
                        const e = this.textContent.trim();
                        window.dataLayer = window.dataLayer || [], window.dataLayer.push({
                            event: "click",
                            click_action: "Footer Menu click",
                            click_value: e
                        })
                    })
                })
            },
            6124() {
                ! function() {
                    const e = document.querySelector("header");

                    function t() {
                        const t = e.offsetHeight;
                        document.documentElement.style.setProperty("--header-height", `${t}px`)
                    }

                    function n(e, t = 100) {
                        let n;
                        return function() {
                            clearTimeout(n), n = setTimeout(() => e.apply(this, arguments), t)
                        }
                    }
                    e && (t(), window.addEventListener("load", t), window.addEventListener("resize", n(t)), new MutationObserver(n(t)).observe(e, {
                        childList: !0,
                        subtree: !0,
                        attributes: !0,
                        characterData: !0
                    }), window.updateHeaderHeight = t)
                }()
            },
            7289() {
                ! function() {
                    function e(e, t = 230) {
                        const n = function(e) {
                            let t = 0;
                            for (; e;) t += e.offsetTop, e = e.offsetParent;
                            return t
                        }(e) - t;
                        window.scrollTo({
                            top: n,
                            behavior: "smooth"
                        }), setTimeout(() => {
                            const t = e.id ? "#" + e.id : "";
                            t && history.pushState(null, window.title, window.location.href.split("#")[0] + t)
                        }, 800)
                    }
                    if (document.addEventListener("click", function(t) {
                            const n = t.target.closest("a");
                            if (!n) return;
                            if (n.classList.contains("open-popup-link") || n.classList.contains("gform_button")) return;
                            if (n.closest(".wp-block-think-blocks-sidebar-toc")) return;
                            const o = n.parentElement;
                            if (!(o && o.classList.contains("open-popup-link") || "" === n.hash || "#search" === n.hash)) {
                                const o = n.hash,
                                    r = document.querySelector(o);
                                if (!r) return;
                                t.preventDefault(), e(r, 230)
                            }
                        }), window.location.hash && (t = window.location.hash, null !== document.querySelector(t))) {
                        const t = document.querySelector(window.location.hash);
                        t && setTimeout(() => {
                            e(t, 230)
                        }, 100)
                    }
                    var t;
                    document.addEventListener("scroll", function() {
                        const e = document.getElementById("menu-main");
                        e && e.classList.contains("mega-menu-open") && e.querySelectorAll(".has-mega-menu").forEach(function(e) {
                            e.classList.remove("has-mega-menu-open")
                        })
                    })
                }()
            },
            1685() {
                function e(e = document) {
                    const t = e.querySelectorAll('a[href*="courses.thinkific.com/signup"]');
                    if (!t.length) return;
                    const n = function() {
                        const e = function() {
                            const e = document.cookie.match(new RegExp("(?:^|; )UserProfile=([^;]*)"));
                            return e ? decodeURIComponent(e[1]) : null
                        }();
                        if (!e) return null;
                        try {
                            const t = JSON.parse(e);
                            if (t.email && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(t.email)) return t.email
                        } catch (e) {
                            console.warn("UserProfile cookie is not valid JSON", e)
                        }
                        return null
                    }();
                    n && t.forEach(e => {
                        try {
                            const t = new URL(e.href, location.href);
                            if (t.searchParams.has("email")) return;
                            if (!/courses\.thinkific\.com$/i.test(t.hostname)) return;
                            if (!/^\/signup\/?$/i.test(t.pathname)) return;
                            t.searchParams.set("email", n), e.href = t.toString()
                        } catch (e) {
                            console.warn("Skipping malformed link", e)
                        }
                    })
                }
                document.addEventListener("DOMContentLoaded", () => {
                    e(), new MutationObserver(t => {
                        t.forEach(t => {
                            t.addedNodes.forEach(t => {
                                1 === t.nodeType && e(t)
                            })
                        })
                    }).observe(document.documentElement, {
                        childList: !0,
                        subtree: !0
                    })
                })
            }
        },
        t = {};

    function n(o) {
        var r = t[o];
        if (void 0 !== r) return r.exports;
        var i = t[o] = {
            exports: {}
        };
        return e[o](i, i.exports, n), i.exports
    }(() => {
        "use strict";
        n(6124), n(7289), n(1685), n(5915)
    })()
})();