document.addEventListener("DOMContentLoaded", () => {
    if (document.body.classList.contains("block-editor-page")) return;
    const e = document.querySelectorAll(".wp-block-think-blocks-swiper-slider.swiper"),
        s = (e, s) => {
            e.el.querySelectorAll("[data-aos]").forEach(e => {
                e.classList.remove("aos-animate"), e.setAttribute("data-aos", e.getAttribute("data-aos-original") || e.getAttribute("data-aos"))
            });
            const t = e.slides[s];
            if (!t) return;
            const i = t.querySelectorAll("[data-aos]");
            setTimeout(() => {
                i.forEach((e, s) => {
                    setTimeout(() => {
                        e.classList.add("aos-animate")
                    }, 100 * s)
                })
            }, 50)
        };
    e.forEach(e => {
        const t = e.dataset.swiper ? JSON.parse(e.dataset.swiper) : {},
            i = e.classList.contains("is-style-case-study"),
            a = e.classList.contains("swiper-case-study-multiple"),
            o = e.classList.contains("is-style-tabbed-slides"),
            n = e.classList.contains("is-style-logo") || !e.classList.contains("is-style-testimonials") && !e.classList.contains("is-style-case-study") && !e.classList.contains("is-style-tabbed-slides"),
            l = e.querySelector(".swiper-pagination"),
            r = i ? {
                slidesPerView: a ? (t.desktopSlidesPerView || 3) + .5 : 1,
                spaceBetween: a ? 20 : 0,
                centeredSlides: !a,
                loop: !!a,
                autoHeight: !1,
                speed: a ? 300 : 3e3,
                breakpoints: a ? {
                    320: {
                        slidesPerView: t.mobileSlidesPerView || 1,
                        spaceBetween: 20
                    },
                    768: {
                        slidesPerView: (t.desktopSlidesPerView || 3) + .5,
                        spaceBetween: 20
                    },
                    1024: {
                        slidesPerView: (t.desktopSlidesPerView || 3) + .5,
                        spaceBetween: 20
                    }
                } : {}
            } : {},
            d = o ? {
                slidesPerView: 1,
                spaceBetween: 0,
                centeredSlides: !0,
                loop: !1,
                autoHeight: !1,
                speed: 600,
                grabCursor: !1
            } : {},
            c = n ? {
                slidesPerView: "auto",
                spaceBetween: 20,
                centeredSlides: !1,
                freeMode: {
                    enabled: !0,
                    momentum: !0,
                    momentumBounce: !1,
                    momentumRatio: .6,
                    momentumVelocityRatio: .6
                },
                speed: 800,
                resistanceRatio: 0,
                breakpoints: {
                    320: {
                        slidesPerView: 2
                    },
                    768: {
                        slidesPerView: 4
                    }
                }
            } : {},
            p = new Swiper(e, {
                loop: !!n || !!a || !i,
                autoplay: !1,
                speed: n ? 4e3 : a ? 300 : 3e3,
                allowTouchMove: !i && !o,
                touchStartPreventDefault: !1,
                touchMoveStopPropagation: !1,
                touchReleaseOnEdges: !0,
                touchAngle: 45,
                touchRatio: 1,
                navigation: !!t.navigation && {
                    nextEl: e.querySelector(".swiper-button-next"),
                    prevEl: e.querySelector(".swiper-button-prev")
                },
                pagination: {
                    el: l,
                    clickable: !0
                },
                a11y: {
                    enabled: !0,
                    containerMessage: "Swiper slider",
                    slideLabelMessage: "Slide {{index}}"
                },
                ...c,
                ...r,
                ...d
            });
        t.autoplay && new IntersectionObserver(e => {
            e.forEach(e => {
                e.isIntersecting ? n ? (p.autoplay.start(), p.params.autoplay = {
                    delay: 1,
                    disableOnInteraction: !1,
                    pauseOnMouseEnter: !1
                }) : (p.autoplay.start(), p.params.autoplay = {
                    delay: 5e3,
                    disableOnInteraction: !1
                }) : p.autoplay.stop()
            })
        }, {
            threshold: .25,
            rootMargin: "0px 0px -50px 0px"
        }).observe(e);
        const u = window.matchMedia("(hover: none), (pointer: coarse)").matches;
        if (n && t.autoplay && !u) {
            let e = !0;
            const s = 1;
            setTimeout(() => {
                const t = p.wrapperEl,
                    i = Array.from(t.children).filter(e => !e.classList.contains("swiper-slide-duplicate"));
                i.forEach(e => {
                    const s = e.cloneNode(!0);
                    s.classList.add("swiper-slide-duplicate"), t.appendChild(s)
                });
                let a = 0;
                i.forEach(e => {
                    a += e.offsetWidth + 20
                });
                let o = 0;
                const n = () => {
                    e && (o -= s, t.style.transform = `translate3d(${o}px, 0px, 0px)`, Math.abs(o) >= a && (o = 0), requestAnimationFrame(n))
                };
                p.allowTouchMove = !1, p.disable(), n(), t.addEventListener("mouseenter", () => {}), t.addEventListener("mouseleave", () => {});
                let l = 0,
                    r = 0,
                    d = !1;
                t.addEventListener("touchstart", s => {
                    e = !1, d = !0, l = s.touches[0].clientX, t.style.transition = "none"
                }), t.addEventListener("touchmove", e => {
                    if (!d) return;
                    r = e.touches[0].clientX;
                    const s = r - l;
                    t.style.transform = `translate3d(${o+s}px, 0px, 0px)`
                }), t.addEventListener("touchend", s => {
                    if (d) {
                        for (d = !1, o += r - l; o > 0;) o -= a;
                        for (; o < -a;) o += a;
                        t.style.transition = "", setTimeout(() => {
                            e = !0, n()
                        }, 1e3)
                    }
                })
            }, 100)
        }
        if ((i || o) && (p.params.pagination.renderBullet = (e, s) => {
                const t = p.slides[e],
                    i = t ? .getAttribute("data-slide-title");
                return i ? `<button class="${s}">${i}</button>` : `<span class="${s}"></span>`
            }, p.pagination.init(), p.pagination.render(), p.pagination.update()), p.on("slideChange", () => {
                const t = p.realIndex,
                    i = p.slides[t],
                    a = i ? .getAttribute("data-slide-title") || "",
                    o = e.classList.contains("is-style-case-study") ? "case-study" : e.classList.contains("is-style-tabbed-slides") ? "tabbed-slides" : e.classList.contains("is-style-testimonials") ? "testimonials" : "logo";
                window.dataLayer = window.dataLayer || [], window.dataLayer.push({
                    event: "swiperSlideChange",
                    sliderStyle: o,
                    slideIndex: t + 1,
                    slideTitle: a
                }), s(p, t)
            }), o) {
            p.slides.forEach((e, s) => {
                e.classList.add("swiper-slide-transition"), 0 === s && e.classList.add("swiper-slide-active")
            }), p.on("slideChangeTransitionStart", () => {
                const e = p.previousIndex ? ? 0,
                    s = p.slides[e];
                s && (s.style.filter = "blur(3px)", s.style.transition = "filter 0.3s ease")
            });
            let e = !1;
            p.on("slideChangeTransitionEnd", () => {
                if (e) return;
                e = !0;
                const s = p.previousIndex ? ? 0,
                    t = p.realIndex ? ? p.activeIndex ? ? 0,
                    i = function(e, s, t) {
                        if (t <= 1) return 1;
                        if (e === s) return 1;
                        const i = (s - e + t) % t;
                        return 0 === i || i <= t / 2 ? 1 : -1
                    }(s, t, p.slides.length);
                p.slides.forEach(e => {
                    e.classList.remove("slide-from-left", "slide-from-right")
                });
                const a = p.slides[t];
                if (a) {
                    const s = 1 === i ? "slide-from-right" : "slide-from-left";
                    a.classList.add(s), setTimeout(() => {
                        a.classList.remove("slide-from-left", "slide-from-right"), e = !1
                    }, 800)
                } else e = !1;
                p.slides.forEach(e => {
                    e.style.filter = "", e.style.transition = ""
                })
            }), p.on("slideChange", () => {
                const e = p.realIndex,
                    s = p.slides[e];
                p.slides.forEach(e => {
                    e.classList.remove("swiper-slide-active")
                }), s.classList.add("swiper-slide-transitioning"), setTimeout(() => {
                    s.classList.add("swiper-slide-active"), s.classList.remove("swiper-slide-transitioning")
                }, 50)
            })
        }
        if (i && t.autoplay) {
            const s = 5e3,
                t = e.querySelectorAll(".swiper-pagination-bullet");
            t.forEach(e => {
                e.style.setProperty("--slide-duration", `${s}ms`)
            }), p.on("slideChange", () => {
                t.forEach(e => {
                    e.classList.remove("progress-active")
                }), requestAnimationFrame(() => {
                    const s = e.querySelector(".swiper-pagination-bullet-active");
                    s && s.classList.add("progress-active")
                })
            }), p.on("init", () => {
                const s = e.querySelector(".swiper-pagination-bullet-active");
                s && s.classList.add("progress-active")
            })
        }
        if (o) {
            const s = () => {
                e.querySelectorAll("figure.wp-block-image").forEach(e => {
                    const s = e.querySelector("img");
                    s && s.src && e.style.setProperty("--bg-image", `url(${s.src})`)
                })
            };
            s(), p.on("slideChange", s)
        }
        p.on("init", () => {
            e.querySelectorAll("[data-aos]").forEach(e => {
                e.setAttribute("data-aos-original", e.getAttribute("data-aos")), e.setAttribute("data-aos", "none")
            }), setTimeout(() => {
                s(p, 0)
            }, 100)
        })
    })
});