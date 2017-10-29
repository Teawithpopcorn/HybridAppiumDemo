import React from 'react';
import 'onsenui/css/onsenui.css';
import 'onsenui/css/onsen-css-components.css';
import {
  Navigator
} from 'react-onsenui';

import RecipeList from './recipeList/RecipesListPage';

const renderPage = (route, navigator) => {
  const {key, title, hasBackButton, params} = route;

  return (
    <route.component key={key} navigator={navigator} title={title} hasBackButton={hasBackButton} {...params}/>
  );
}

const App = () => (
  <Navigator
    renderPage={renderPage}
    initialRoute={{component: RecipeList, key: 'RECIPE_LIST'}}
  />
);

export default App;
