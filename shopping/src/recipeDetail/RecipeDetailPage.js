import React, {Component} from 'react';
import {
  Page,
  Button
} from 'react-onsenui';
import NavBar from '../shared/NavBar';

export default class GoodsDetailPage extends Component {
  render() {
    const {navigator, title, hasBackButton} = this.props;

    return (
      <Page renderToolbar={() => <NavBar title={title} backButton={hasBackButton} navigator={navigator} />}>
        <section style={{margin: '16px', textAlign: 'center'}}>
          <Button>
            Push Page2
          </Button>
        </section>
      </Page>
    )
  }
}
