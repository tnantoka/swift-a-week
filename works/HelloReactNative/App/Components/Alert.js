import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  AlertIOS,
} from 'react-native';

class Alert extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TouchableHighlight onPress={() => AlertIOS.alert('title', 'message')}>
          <Text style={styles.message}>
            Show Alert
          </Text>
        </TouchableHighlight>
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

module.exports = Alert;

