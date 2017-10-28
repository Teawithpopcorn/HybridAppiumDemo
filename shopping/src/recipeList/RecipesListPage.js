import React, {Component} from 'react';
import {
  Page,
  List,
  SearchInput
} from 'react-onsenui';
import _ from 'lodash';
import NavBar from '../shared/NavBar';
import recipes from './AllRecipes';
import RecipeCard from './Recipe';
import RecipeDetail from '../recipeDetail/RecipeDetailPage';

export default class RecipeListPage extends Component {
  constructor(props) {
    super(props)
    this.state = {
      searchText: null,
      recipeList: recipes
    }
  }

  searchTextChanged(e) {
    const searchText = _.get(e, 'target.value', '');
    const recipeList = this.filterRecipes(searchText);
    this.setState({
      searchText,
      recipeList
    });
  }

  filterRecipes(searchText) {
    if (_.isEmpty(searchText)) return recipes;

    return _.filter(recipes, recipe => _.includes(recipe.name, searchText));
  }

  renderRecipe(row, index) {
    const { recipeList } = this.state;
    const recipe = recipeList[index];

    return <RecipeCard
      key={index}
      name={recipe.name}
      picture={recipe.picture}
      tapRecipe={this.transitionToDetailPage.bind(this)}
    />
  }

  transitionToDetailPage() {
    const {navigator} = this.props;
    navigator.pushPage({
      title: `Recipe Detail`,
      hasBackButton: true,
      component: RecipeDetail
    });
  }

  render() {
    const {navigator} = this.props;
    return (
      <Page renderToolbar={() => <NavBar title='附近美食' navigator={navigator} />}>
        <div style={{padding: '8px 10px', backgroundColor: '#fafafa'}}>
          <SearchInput placeholder='Search' style={{width: '100%'}} onChange={this.searchTextChanged.bind(this)}/>
        </div>
        <List dataSource={this.state.recipeList} renderRow={this.renderRecipe.bind(this)}/>
      </Page>
    )
  }
}
