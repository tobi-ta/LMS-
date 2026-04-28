(() => {
    var e = {
            485() {
                document.addEventListener("DOMContentLoaded", function() {
                    const e = document.querySelectorAll("form[data-form-id]");
                    if (0 === e.length) return;
                    const t = Cookies.get("UserProfile") ? JSON.parse(Cookies.get("UserProfile")) : {};
                    e.forEach(e => {
                        const s = e.getAttribute("data-form-id"),
                            i = e.getAttribute("data-unique-instance-id") || s,
                            o = hubspotProgressiveData.progressiveMappings[i] || {},
                            r = "true" === e.getAttribute("data-hide-known-fields");
                        let a = "none",
                            n = !1,
                            l = !1;
                        const d = {};

                        function c() {
                            r && hubspotProgressiveData.allowedFields.forEach(s => {
                                if ("consent" === s || "email" === s) return;
                                const i = e.querySelector(`[name="${s}"]`);
                                if (i && "SELECT" === i.tagName && t[s]) {
                                    const r = i.closest(".wp-block-group");
                                    if (r && e.contains(r) && (i.value.trim() || t[s])) {
                                        const i = o[s],
                                            a = i ? e.querySelector(`[name="${i}"]`) : null,
                                            d = !!a && ("SELECT" === a.tagName ? t[i] : a.value.trim() || t[i]);
                                        if (a) {
                                            if (r.classList.add("hidden-field"), l = !0, !d) {
                                                const t = a.closest(".wp-block-group, .hidden-field");
                                                t && e.contains(t) && (t.classList.remove("hidden-field"), t.classList.add("visible-field"), n = !0)
                                            }
                                        } else r.classList.add("hidden-field"), l = !0
                                    }
                                }
                            })
                        }
                        hubspotProgressiveData.allowedFields.forEach(s => {
                            if ("consent" === s) return;
                            const i = e.querySelector(`[name="${s}"]`);
                            if (i && (t[s] && "SELECT" !== i.tagName && (i.value = t[s], i.classList.add("prefilled"), d[s] = i.value.trim(), a = "profile"), t[s] && "SELECT" === i.tagName && (d[s] = t[s], a = "profile"), "email" !== s)) {
                                const a = i.closest(".wp-block-group");
                                if (a && e.contains(a) && ("SELECT" === i.tagName ? t[s] : i.value.trim() || t[s])) {
                                    const i = o[s],
                                        d = i ? e.querySelector(`[name="${i}"]`) : null,
                                        c = !!d && ("SELECT" === d.tagName ? t[i] : d.value.trim() || t[i]);
                                    if ((r || d) && (a.classList.add("hidden-field"), l = !0, d && (!r || !c))) {
                                        const t = d.closest(".wp-block-group, .hidden-field");
                                        t && e.contains(t) && (t.classList.remove("hidden-field"), t.classList.add("visible-field"), n = !0)
                                    }
                                }
                            }
                        }), setTimeout(c, 300), setTimeout(c, 600), setTimeout(c, 1e3), e.dataset.prefillSource = a, e.dataset.progressiveFilled = n, e.dataset.hasHiddenFields = l
                    })
                })
            }
        },
        t = {};

    function s(i) {
        var o = t[i];
        if (void 0 !== o) return o.exports;
        var r = t[i] = {
            exports: {}
        };
        return e[i](r, r.exports, s), r.exports
    }(() => {
        "use strict";
        String.prototype.toProperCase = function() {
            return this.replace(/\w\S*/g, function(e) {
                return e.charAt(0).toUpperCase() + e.substring(1).toLowerCase()
            })
        }, s(485)
    })()
})();