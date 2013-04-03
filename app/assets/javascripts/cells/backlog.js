(function($) {

  var Backlog = Cell.create('Backlog');

  Backlog.prototype.initialize = function() {
    var _this = this;

    _this.list = _this.$target.find('.issue-list');
    _this.url = _this.$target.find('.btn-refresh').attr("href");

    _this.$target.on("click", ".btn-refresh", function() {
      event.preventDefault();

      _this.refresh();
    });

    $(window).bind("popstate", function() {
      if (event.state && event.state.tag) {
        _this.refresh(false, event.state);
        Sorting.instances[0].resetState(event.state);
        Filter.instances[0].resetState(event.state);
        Pagination.instances[0].resetState(event.state);
        SearchForm.instances[0].resetState(event.state);
      }
    });
  };

  Backlog.prototype.refresh = function(updateHistory, data) {
    var _this = this;

    var sorting = Sorting.instances[0];
    var filter = Filter.instances[0];
    var pagination = Pagination.instances[0];
    var searchForm = SearchForm.instances[0];

    LoadingIndicator.addTo(".issue-list");

    if (!data) {
      var data = {
        sorting: sorting.options(),
        filter: filter.options(),
        pagination: pagination.options(),
        query: searchForm.options()
      }
    }

    var options = {
      data: data,
      success: function(data) {
        _this.list.html(data);
        Pagination.instances = [];
        new Pagination(_this.list.find('[data-cell="Pagination"]'));
      }
    };

    if (updateHistory) {
      data.tag = "tyne";
      var baseUrl = document.URL.substring(0, document.URL.indexOf("?"));
      var params = $.param(data);
      var decoded = decodeURIComponent(params);
      history.pushState(data, null, baseUrl + "?" + decoded)
    }

    $.ajax(_this.url, options);
  };

  $(function() {
    var sorting = Sorting.instances[0];
    var filter = Filter.instances[0];
    var searchForm = SearchForm.instances[0];
    var url = document.URL;
    var params = $.String.deparam((url.split('?')[1] || ''));

    if (filter) filter.resetState(params);
    if (sorting) sorting.resetState(params);
    if (searchForm) searchForm.resetState(params);

    if (filter && sorting && searchForm) {
      history.replaceState({ sorting: params.sorting, filter: params.filter, tag: "tyne" });
    }
  });
})(jQuery);
