import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  NativeModules,
} from 'react-native';

const HelloSwift = NativeModules.HelloSwift;

class Swift extends Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  initialState() {
    return {
      message: '',
    };
  }

  componentDidMount() {
    HelloSwift.hello('Swift', (result) => {
      this.setState({ message: result });
    });
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.message}>
          { this.state.message }
        </Text>
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

module.exports = Swift;

