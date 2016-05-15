import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NavigatorIOS,
} from 'react-native';

import Home from './App/Components/Home';

class MainView extends Component {
  render() {
    return (
      <NavigatorIOS style={styles.navigator} initialRoute={{
        title: "Hello, React Native",
        component: Home,
      }} />
    );
  }
}

const styles = StyleSheet.create({
  navigator: {
    flex: 1,
  },
});

AppRegistry.registerComponent('HelloWorld', () => MainView);
