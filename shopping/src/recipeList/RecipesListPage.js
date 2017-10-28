import React, {Component} from 'react';
import {
  Page
} from 'react-onsenui';
import NavBar from '../shared/NavBar';

export default class RecipeListPage extends Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {navigator} = this.props;
    return (
      <Page renderToolbar={() => <NavBar title='附近美食' navigator={navigator} />}>
        <section style={{margin: '16px', textAlign: 'center'}}>
        </section>
      </Page>
    )
  }
}
