import React, {Component} from 'react';
import {
  Page,
  List,
  ListItem,
  SearchInput
} from 'react-onsenui';
import _ from 'lodash'
import NavBar from '../shared/NavBar';
import recipes from './AllRecipes'

export default class RecipeListPage extends Component {
  constructor(props) {
    super(props)
    this.state = {
      searchText: null
    }
  }

  searchTextChanged(text) {
    this.setState({
      searchText: text
    });
  }

  filterRecipes() {
    return recipes
  }

  renderRecipe(row, index) {
    return (
      <ListItem key={index}>
        <div className='left'>
          <img src={`http://placekitten.com/g/40/40`} className='list-item__thumbnail' />
        </div>
        <div className='center'>
          'name'
      </div>
      </ListItem>)
  }

  render() {
    const {navigator} = this.props;
    return (
      <Page renderToolbar={() => <NavBar title='附近美食' navigator={navigator} />}>
        <div style={{padding: '8px 10px', backgroundColor: '#fafafa'}}>
          <SearchInput placeholder='Search' style={{width: '100%'}} />
        </div>
        <List dataSource={this.filterRecipes.bind(this)()} renderRow={this.renderRecipe.bind(this)}/>
      </Page>
    )
  }
}
