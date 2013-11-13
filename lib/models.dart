      });
    });
    return new Model(_attributes);
  }

  /// Attributes as JSON string.
  toJson() => JSON.encode(_attributes);

  Map<String, dynamic> get attributes => _attributes;

  Stream on(String name) => _emitter.on(name);

}
