typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,
  }) {
    _instanceMap[T] = _InstanceGenerator(instance, isSingleton: isSingleton);
  }

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFristGet = false;

  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, {bool isSingleton = false})
      : _isFristGet = isSingleton;

  T? getInstance() {
    if (_isFristGet) {
      _instance = _instanceCreator();
      _isFristGet = false;
    }

    return _instance ?? _instanceCreator();
  }
}
