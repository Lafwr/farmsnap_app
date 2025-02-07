import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

eagerLoadControllersFrom("controllers", application);

// Ensure crates_controller.js is properly registered
// import "./crates_controller";
