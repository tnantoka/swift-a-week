import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
} from 'react-native';

class Flexbox extends Component {
  render() {
    return (
      <View style={styles.container}>
        <View style={styles.row1}>
          <View style={styles.col1}>
            <Text>col 1-1</Text>
          </View>
          <View style={styles.col2}>
            <Text>col 1-2</Text>
          </View>
        </View>
        <View style={styles.row2}>
          <View style={styles.col1}>
            <Text>col 2-1</Text>
          </View>
          <View style={styles.col2}>
            <Text>col 2-2</Text>
          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  row1: {
    flex: 1,
  },
  row2: {
    flex: 1,
    flexDirection: 'row',
  },
  col1: {
    flex: 2,
    backgroundColor: '#bbb',
    justifyContent: 'center',
    alignItems: 'center',
  },
  col2: {
    flex: 1,
    backgroundColor: '#ddd',
    justifyContent: 'center',
    alignItems: 'center',
  },
});

module.exports = Flexbox

