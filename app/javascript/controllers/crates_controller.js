import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slider", "list"];

  connect() {
    console.log("Crates controller connected!");

    this.slider = this.element.querySelector("#slider");
    this.sliderThumb = this.element.querySelector("#slider-thumb");
    this.isFlashSale = true; // Default to Flash Sales

    this.updateUI();
    this.filterCrates(); // Apply filtering immediately on page load

    this.slider.addEventListener("click", this.toggleFilter.bind(this));
  }

  toggleFilter() {
    this.isFlashSale = !this.isFlashSale;
    this.updateUI();
    this.filterCrates();
  }

  updateUI() {
    if (this.isFlashSale) {
      this.slider.classList.add("slider-active");
      this.sliderThumb.style.left = "0px"; // Move pin to the left (Flash Sales default)
    } else {
      this.slider.classList.remove("slider-active");
      this.sliderThumb.style.left = "35px"; // Move pin to the right (All Crates)
    }
}

  filterCrates() {
    const crates = document.querySelectorAll(".crate");
    crates.forEach((crate) => {
      const isFlashSale = crate.dataset.flashSale === "true";
      if (this.isFlashSale && !isFlashSale) {
        crate.style.display = "none";
      } else {
        crate.style.display = "block";
      }
    });
  }
}
