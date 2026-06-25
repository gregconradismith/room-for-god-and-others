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
    var status = browser.querySelector("[data-browser-status]");
    var items = Array.prototype.slice.call(browser.querySelectorAll("[data-browser-item]"));
    var params = new URLSearchParams(window.location.search);
    var selectedTheme = browser.getAttribute("data-selected-theme") || params.get("theme") || params.get("category") || "";

    function matchesTheme(item, theme) {
      if (!theme) {
        return true;
      }

      var itemThemes = (item.getAttribute("data-themes") || "").split("|");
      return itemThemes.indexOf(theme) !== -1;
    }

    function updateResults() {
      var query = normalized(search ? search.value : "");
      var hasFilter = query.length > 0 || selectedTheme.length > 0;
      var visible = 0;

      items.forEach(function (item) {
        var textMatch = !query || normalized(item.getAttribute("data-search")).indexOf(query) !== -1;
        var themeMatch = matchesTheme(item, selectedTheme);
        var show = hasFilter && textMatch && themeMatch;

        item.hidden = !show;
        if (show) {
          visible += 1;
        }
      });

      if (!status) {
        return;
      }

      if (!hasFilter) {
        status.textContent = "Enter a search term.";
      } else if (visible === 1) {
        status.textContent = selectedTheme ? "1 result in " + selectedTheme : "1 result";
      } else {
        status.textContent = selectedTheme ? visible + " results in " + selectedTheme : visible + " results";
      }
    }

    if (search && params.get("q")) {
      search.value = params.get("q");
    }

    if (search) {
      search.addEventListener("input", updateResults);
    }

    updateResults();
  });
}());
