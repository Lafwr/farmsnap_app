import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["star"];

  connect() {
    this.stars = Array.from(this.element.querySelectorAll(".star"));
    this.hiddenInput = document.getElementById("rating-hidden");
    this.resetStars();
  }

  resetStars() {
    this.stars.forEach(star => {
      star.style.color = "#ccc"; // Default color (gray)
    });
  }

  highlight(event) {
    const selectedIndex = this.stars.indexOf(event.target); // Get index of hovered star
    this.stars.forEach((star, index) => {
      star.style.color = index <= selectedIndex ? "black" : "#ccc"; // Fill stars up to hovered one
    });
  }

  select(event) {
    const selectedValue = event.target.dataset.value; // Get value of clicked star
    this.hiddenInput.value = selectedValue; // Save rating in hidden field

    this.stars.forEach((star, index) => {
      star.style.color = index < selectedValue ? "black" : "#ccc"; // Fill stars up to selected one
    });
  }
}
