! function() {
    function t(t) {
        if (t.classList.contains("open-popup-link")) {
            const e = new CustomEvent("modalclick", {
                bubbles: !0
            });
            t.dispatchEvent(e)
        } else "_blank" === t.getAttribute("target") ? window.open(t.getAttribute("href"), "_blank", "noopener") : window.location.href = t.getAttribute("href")
    }
    document.addEventListener("click", function(t) {
        t.target.closest(".is-style-category-card.linked-card a") && t.preventDefault()
    }), document.addEventListener("click", function(e) {
        const n = e.target.closest(".is-style-category-card.linked-card");
        if (!n) return;
        let c = n.classList.contains("is-style-category-card") ? n : n.closest(".is-style-category-card");
        if (!c) return;
        const o = c.querySelector("a");
        o && t(o)
    }), document.addEventListener("click", function(t) {
        t.target.closest(".wp-block-column.linked-card a, .wp-block-group.linked-card a") && t.preventDefault()
    }), document.addEventListener("click", function(e) {
        const n = e.target.closest(".wp-block-column.linked-card, .wp-block-group.linked-card");
        if (!n) return;
        if ("A" === e.target.tagName || e.target.closest("a")) return;
        const c = n.querySelector("a");
        c && t(c)
    })
}();