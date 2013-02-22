(function(exports, undefined) {
  /**
   * Parses a dot-separated name and returns an array containing the name parts.
   *
   * @param [String] name
   * @return [Array]
   */
  function parseName(name) {
    var i,
        path = name.split('.'),
        n = path.length;

    for (i = n - 1; i >= 0; --i) {
      if (path[i].match(/^\s*$/)) {
        path.splice(i, 1)
      }
    }

    return path;
  }

  /**
   * ClassRegistry provides methods for handling namespaced "classes".
   */
  function ClassRegistry() {
  }

  /**
   * ClassRegistry modifies the defined storage only.
   */
  ClassRegistry.storage = {};

  /**
   * Checks if a class exists whereby the given name may be a dot-separated
   * path describing the class' namespace. Example:
   *
   * ClassRegistry.exists("Foo.Bar") checks for ClassRegistry.storage.Foo.Bar
   *
   * @param [String] name
   * @return [Boolean]
   */
  ClassRegistry.exists = function(name) {
    var i,
        path = parseName(name),
        n = path.length,
        root = ClassRegistry.storage;

    for (i = 0; i < n - 1; ++i) {
      if (undefined == root[path[i]]) {
        return false;
      }
      root = root[path[i]];
    }

    return !(undefined == root[path[i]]);
  };

  /**
   * Returns a class whereby the given name may be a dot-separated path
   * describing the class' namespace. Example:
   *
   * ClassRegistry.get('Foo.Bar') return ClassRegistry.storage.Foo.Bar
   *
   * @param [String] name
   * @return [Object]
   */
  ClassRegistry.get = function(name) {
    var i,
        path = parseName(name),
        n = path.length,
        root = ClassRegistry.storage;

    for (i = 0; i < n - 1; ++i) {
      if (undefined == root[path[i]]) {
        return;
      }
      root = root[path[i]];
    }

    if (root[path[i]]) {
      return root[path[i]];
    }
  };

  /**
   * Sets a class whereby the given name may be a dot-separated path describing
   * the class' namespace. Example:
   *
   * var fooBar = function() { };
   * ClassRegistry.set('Foo.Bar', function() { }) stores the closure at ClassRegistry.Foo.Bar
   *
   * @param [String] name
   * @param [Object] klass
   */
  ClassRegistry.set = function(name, klass) {
    var i,
        path = parseName(name),
        n = path.length,
        root = ClassRegistry.storage;

    for (i = 0; i < n - 1; ++i) {
      root[path[i]] = root[path[i]] || {};
      root = root[path[i]];
    }
    root[path[i]] = klass;

    return klass;
  };

  exports.ClassRegistry = ClassRegistry;
})(window);

/**
 * Use window as storage for class registration
 */
ClassRegistry.storage = window;
