document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".wp-block-cover").forEach(e => {
        const t = e.querySelector(".wp-block-cover__background"),
            o = e.querySelector(".tick-circle-svg");
        if (t) {
            const o = window.getComputedStyle(t).backgroundColor;
            e.style.setProperty("--tick-circle-fill", o)
        }
        const r = window.getComputedStyle(e).getPropertyValue("--tick-line-stroke");
        r && (e.style.setProperty("--tick-line-stroke", r.trim()), o && o.style.setProperty("--tick-line-stroke", r.trim()))
    })
});