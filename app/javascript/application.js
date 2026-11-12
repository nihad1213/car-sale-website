import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

function openAuthModalIfNeeded() {
  const el = document.getElementById("authModal");
  if (!el) return;

  const shouldOpen =
    el.dataset.open === "true" ||
    new URLSearchParams(location.search).get("open_auth") === "1";

  if (shouldOpen) {
    bootstrap.Modal.getOrCreateInstance(el).show();
  }
}

document.addEventListener("turbo:load", openAuthModalIfNeeded);

document.addEventListener("turbo:before-cache", () => {
  document.querySelectorAll(".modal.show, .dropdown-menu.show")
    .forEach(el => el.classList.remove("show"));

  document.querySelectorAll(".modal-backdrop").forEach(el => el.remove());

  document.body.classList.remove("modal-open");
  document.body.style.removeProperty("overflow");
  document.body.style.removeProperty("padding-right");
});