(function () {
  function onReady(callback) {
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", callback);
      return;
    }

    callback();
  }

  function normalized(value) {
    return (value || "").toLowerCase().trim();
  }

  onReady(function () {
    var browser = document.querySelector("[data-writing-browser]");
    if (!browser) {
      return;
    }

    var search = browser.querySelector("[data-browser-search]");
    var toggle = browser.querySelector("[data-category-toggle]");
    var panel = browser.querySelector("[data-category-panel]");
    var status = browser.querySelector("[data-browser-status]");
    var items = Array.prototype.slice.call(browser.querySelectorAll("[data-browser-item]"));
    var filters = Array.prototype.slice.call(browser.querySelectorAll("[data-category-filter]"));

    function activeCategories() {
      return filters
        .filter(function (filter) { return filter.checked; })
        .map(function (filter) { return filter.value; });
    }

    function matchesCategory(item, categories) {
      if (!categories.length) {
        return true;
      }

      var itemCategories = (item.getAttribute("data-categories") || "").split("|");
      return categories.some(function (category) {
        return itemCategories.indexOf(category) !== -1;
      });
    }

    function updateResults() {
      var query = normalized(search ? search.value : "");
      var categories = activeCategories();
      var hasFilter = query.length > 0 || categories.length > 0;
      var visible = 0;

      items.forEach(function (item) {
        var textMatch = !query || normalized(item.getAttribute("data-search")).indexOf(query) !== -1;
        var categoryMatch = matchesCategory(item, categories);
        var show = hasFilter && textMatch && categoryMatch;

        item.hidden = !show;
        if (show) {
          visible += 1;
        }
      });

      if (!status) {
        return;
      }

      if (!hasFilter) {
        status.textContent = "Search all writing or choose a category.";
      } else if (visible === 1) {
        status.textContent = "1 result";
      } else {
        status.textContent = visible + " results";
      }
    }

    if (toggle && panel) {
      toggle.addEventListener("click", function () {
        var expanded = toggle.getAttribute("aria-expanded") === "true";
        toggle.setAttribute("aria-expanded", expanded ? "false" : "true");
        panel.hidden = expanded;
      });
    }

    if (search) {
      search.addEventListener("input", updateResults);
    }

    filters.forEach(function (filter) {
      filter.addEventListener("change", updateResults);
    });

    updateResults();
  });
}());
