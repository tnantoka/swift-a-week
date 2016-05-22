import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  WebView,
} from 'react-native';

class Web extends Component {
  render() {
    return (
      <View style={styles.container}>
        <WebView source={{ uri: 'http://google.com/' }}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

module.exports = Web;

