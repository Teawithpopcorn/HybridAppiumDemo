import React, {Component} from 'react';
import {
  Page,
  List,
  SearchInput
} from 'react-onsenui';
import NavBar from '../shared/NavBar';
import recipes from './AllRecipes'
import RecipeCard from './Recipe'
import RecipeDetail from '../recipeDetail/RecipeDetailPage'

export default class RecipeListPage extends Component {
  constructor(props) {
    super(props)
    this.state = {
      searchText: null,
      recipeList: recipes
    }
  }

  searchTextChanged(text) {
    this.setState({
      searchText: text
    });
  }

  filterRecipes() {
    return recipes;
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
          <SearchInput placeholder='Search' style={{width: '100%'}} />
        </div>
        <List dataSource={this.filterRecipes.bind(this)()} renderRow={this.renderRecipe.bind(this)}/>
      </Page>
    )
  }
}
