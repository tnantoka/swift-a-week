import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
} from 'react-native';

class HelloWorld extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Image source={require('../Images/header_logo.png')} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#3b3738',
  },
});

module.exports = HelloWorld;

