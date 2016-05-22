import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Animated,
} from 'react-native';




class Animation extends Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  initialState() {
    return {
      fadeValue: new Animated.Value(0),
    };
  }

  componentDidMount() {
    Animated.timing(
      this.state.fadeValue,
      { toValue: 1, duration: 2000 }
    ).start();
  } 

  render() {
    return (
      <View style={styles.container}>
        <Animated.View style={{ opacity: this.state.fadeValue }}>
          <Text style={styles.message}>
            Hello, World!
          </Text>
        </Animated.View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  message: {
    fontSize: 20,
  },
});

module.exports = Animation;

