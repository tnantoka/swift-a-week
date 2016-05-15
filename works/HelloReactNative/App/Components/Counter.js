import React, {
  Component,
  PropTypes,
} from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
} from 'react-native';

import { EventEmitter } from 'events';
import { Dispatcher } from 'flux';

const AppDispatcher = new Dispatcher();

const COUNTER_INCREMENT = 'COUNTER_INCREMENT';
const COUNTER_DECREMENT = 'COUNTER_DECREMENT';
const Constants = {
  COUNTER_INCREMENT,
  COUNTER_DECREMENT,
};

const Actions = {
  increment() {
    AppDispatcher.dispatch({
      actionType: Constants.COUNTER_INCREMENT,
    });
  },
  decrement() {
    AppDispatcher.dispatch({
      actionType: Constants.COUNTER_DECREMENT,
    });
  },
};

const CHANGE_EVENT = 'change';
var _count = 0;
const Store = Object.assign({}, EventEmitter.prototype, {
  getCount: () => _count,
  emitChange() {
    this.emit(CHANGE_EVENT);
  },
  addChangeListener(callback) {
    this.on(CHANGE_EVENT, callback);
  },
  dispatcherIncrement: AppDispatcher.register((payload) => {
    if (payload.actionType === Constants.COUNTER_INCREMENT) {
      _count++;
      Store.emitChange(); 
    }
  }),
  dispatcherDecrement: AppDispatcher.register((payload) => {
    if (payload.actionType === Constants.COUNTER_DECREMENT) {
      _count--;
      Store.emitChange(); 
    }
  }),
});

// AppDispatcher.register((action) => {
//   switch(action.actionType) {
//     case Constants.COUNTER_INCREMENT:
//       break;
//     case Constants.COUNTER_DECREMENT:
//       break;
//   }
// });

class Counter extends Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  initialState() {
    return {
      count: Store.getCount(),
    };
  }

  componentDidMount() {
    Store.addChangeListener(() => {
      this.setState({ count: Store.getCount() });
    });
  }

  render() {
    return (
      <CounterView count={this.state.count}/>
    );
  }
}

class CounterView extends Component {
  constructor(props) {
    super(props);
    // this.state = this.initialState();
    this._onPressIncrement = this._onPressIncrement.bind(this);
    this._onPressDecrement = this._onPressDecrement.bind(this);
  }

  static propTypes = {
    count: PropTypes.number.isRequired
  }

  // initialState() {
  //   return {
  //     count: 0,
  //   };
  // }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.row}>
          <Text style={styles.message}>
            { this.props.count }
          </Text>
        </View>
        <View style={styles.row}>
          <TouchableHighlight onPress={this._onPressIncrement} style={styles.button}>
            <Text style={styles.message}>+</Text>
          </TouchableHighlight>
          <TouchableHighlight onPress={this._onPressDecrement} style={styles.button}>
            <Text style={styles.message}>-</Text>
          </TouchableHighlight>
        </View>
      </View>
    );
  }

  _onPressIncrement() {
    // this.setState({ count: this.state.count + 1 });
    Actions.increment();
  }
  _onPressDecrement() {
    // this.setState({ count: this.state.count - 1 });
    Actions.decrement();
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  message: {
    fontSize: 20,
    textAlign: 'center',
  },
  row: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  button: {
    flex: 1,
    alignSelf: 'stretch',
    justifyContent: 'center',
  },
});

module.exports = Counter;

