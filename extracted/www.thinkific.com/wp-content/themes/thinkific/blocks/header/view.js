! function() {
    const e = document.body,
        t = document.querySelector("header"),
        n = document.querySelector(".main-menu-toggle"),
        o = document.querySelector("header .menus"),
        s = document.querySelectorAll("li.has-mega-menu > button");

    function i(e, t) {
        t ? (e.setAttribute("hidden", ""), e.setAttribute("inert", "")) : (e.removeAttribute("hidden"), e.removeAttribute("inert"))
    }

    function c() {
        e.style.overflow = "", e.style.position = "", e.style.width = ""
    }

    function a(e) {
        const t = document.getElementById("menu-status");
        t && (t.textContent = e)
    }

    function r() {
        document.querySelectorAll("li.has-mega-menu").forEach(function(e) {
            e.classList.remove("has-mega-menu-open");
            const t = Array.from(e.children).find(function(e) {
                return "BUTTON" === e.tagName
            });
            t && t.setAttribute("aria-expanded", "false")
        }), document.querySelectorAll(".mega-menu").forEach(function(e) {
            e.classList.remove("is-visible"), i(e, !0)
        });
        const e = document.getElementById("menu-main"),
            t = document.getElementById("menu-main-fr");
        e && e.classList.remove("mega-menu-open"), t && t.classList.remove("mega-menu-open"), a("Menu closed");
        const o = document.querySelector('li.has-mega-menu > button[aria-expanded="true"]');
        o ? o.focus() : n && n.focus()
    }
    let u;
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll(".mega-menu").forEach(function(e) {
            e.classList.contains("is-visible") || i(e, !0)
        })
    }), n && n.addEventListener("click", function() {
        ! function() {
            n && n.classList.toggle("cross"), e && e.classList.toggle("no-scroll"), t && t.classList.toggle("menu-open");
            const s = document.getElementById("site-navigation"),
                i = s ? s.parentElement : null;
            if (i) {
                const t = i.classList.contains("open");
                i.classList.toggle("open"), i.classList.contains("open") ? (i.classList.remove("closing"), function(e) {
                    if (!e) return;
                    const t = Array.from(e.querySelectorAll('a, button, input, textarea, select, [tabindex]:not([tabindex="-1"])')),
                        n = t[0],
                        o = t[t.length - 1];
                    e.addEventListener("keydown", function(e) {
                        if ("Tab" === e.key) {
                            const t = document.activeElement;
                            e.shiftKey && t === n ? (e.preventDefault(), o && o.focus()) : e.shiftKey || t !== o || (e.preventDefault(), n && n.focus())
                        }
                    })
                }(o), e.style.overflow = "hidden", e.style.position = "fixed", e.style.width = "100%") : (t && (i.classList.add("closing"), setTimeout(function() {
                    i.classList.remove("closing")
                }, 300)), c())
            }
        }()
    }), s.forEach(function(e) {
        e.addEventListener("click", function(e) {
            const t = this,
                n = t.parentElement,
                o = n ? n.querySelector(".mega-menu") : null,
                s = n && n.classList.contains("has-mega-menu-open"),
                c = t.textContent.trim().replace(/\s+/g, " "),
                u = window.matchMedia("(max-width: 1024px)").matches ? "Main Menu Mobile drop down" : "Main Menu Desktop drop down";
            if (window.dataLayer = window.dataLayer || [], window.dataLayer.push({
                    event: "click",
                    click_action: u,
                    click_value: c
                }), r(), !s && n && o) {
                n.classList.add("has-mega-menu-open"), o.classList.add("is-visible"), i(o, !1);
                const e = document.getElementById("menu-main"),
                    s = document.getElementById("menu-main-fr");
                e && e.classList.add("mega-menu-open"), s && s.classList.add("mega-menu-open"), t.setAttribute("aria-expanded", "true");
                const c = 'a, button, input, textarea, select, [tabindex]:not([tabindex="-1"])',
                    r = o.querySelector(c);
                r && r.focus(), a("Menu opened")
            }
        })
    }), document.body.addEventListener("click", function(e) {
        const t = e.target.closest(".mega-menu a");
        if (!t) return;
        const n = t.textContent.trim(),
            o = window.matchMedia("(max-width: 1024px)").matches ? "Main Menu Mobile click" : "Mega Menu inner click";
        window.dataLayer = window.dataLayer || [], window.dataLayer.push({
            event: "click",
            click_action: o,
            click_value: n
        })
    }), window.addEventListener("scroll", r), document.addEventListener("click", function(e) {
        e.target.closest("li.has-mega-menu") || r()
    }), window.addEventListener("resize", function() {
        clearTimeout(u), u = setTimeout(function() {
            window.matchMedia("(min-width: 1024px)").matches && o && o.classList.contains("open") && (n && n.classList.remove("cross"), e && e.classList.remove("no-scroll"), t && t.classList.remove("menu-open"), o.classList.remove("open"), c())
        }, 100)
    }), document.body.addEventListener("keydown", function(e) {
        const t = e.target.closest(".has-mega-menu > button");
        t && ("Enter" !== e.key && " " !== e.key || (e.preventDefault(), t.click()))
    }), document.addEventListener("keydown", function(e) {
        const t = document.activeElement,
            n = t.closest(".mega-menu"),
            o = t.closest(".has-mega-menu > button");
        if ("Escape" !== e.key) {
            if (n) {
                const o = 'a, button, input, textarea, select, [tabindex]:not([tabindex="-1"])',
                    s = Array.from(n.querySelectorAll(o)),
                    i = s.indexOf(t);
                if ("ArrowDown" === e.key) {
                    e.preventDefault();
                    const t = s[i + 1] || s[0];
                    t && t.focus()
                }
                if ("ArrowUp" === e.key) {
                    e.preventDefault();
                    const t = s[i - 1] || s[s.length - 1];
                    t && t.focus()
                }
                "Tab" === e.key && (e.shiftKey && 0 === i ? (e.preventDefault(), s[s.length - 1].focus()) : e.shiftKey || i !== s.length - 1 || (e.preventDefault(), s[0].focus()))
            }
            if (o) {
                const t = Array.from(document.querySelectorAll("li.has-mega-menu > button")),
                    n = t.indexOf(o);
                if ("ArrowRight" === e.key || "ArrowDown" === e.key) {
                    e.preventDefault();
                    const o = t[n + 1];
                    o && o.focus()
                }
                if ("ArrowLeft" === e.key || "ArrowUp" === e.key) {
                    e.preventDefault();
                    const o = t[n - 1];
                    o && o.focus()
                }
            }
        } else document.querySelector(".mega-menu.is-visible") && (e.preventDefault(), r())
    }), document.addEventListener("click", function(e) {
        const t = e.target.closest(".wp-block-group.mega-menu-link");
        if (!t) return;
        if ("A" === e.target.tagName || e.target.closest("a")) return;
        const n = t.querySelector("a");
        if (!n) return;
        const o = n.getAttribute("href");
        "_blank" === (n.getAttribute("target") || "").toLowerCase() ? window.open(o, "_blank", "noopener") : window.location.href = o
    })
}();