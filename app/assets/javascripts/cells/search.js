(function($) {

  var Search = Cell.create('Search');

  Search.prototype.initialize = function() {
    var _this = this;

    _this.$target.on("click", "a", function() {
      _this.resetState();

      var filterData = $(this).data("filter");
      var data = {
        sorting: Sorting.instances[0].options(),
        filter: filterData,
        pagination: Pagination.instances[0].options()
      }
      $(this).addClass("selected");

      Backlog.instances[0].refresh(true, data);
      Filter.instances[0].resetState(data);
    });
  };

  Search.prototype.resetState = function(data) {
    this.$target.find("a").removeClass("selected");
  };
})(jQuery);
