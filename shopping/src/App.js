import React from 'react';
import 'onsenui/css/onsenui.css';
import 'onsenui/css/onsen-css-components.css';
import {
  Navigator
} from 'react-onsenui';

import RecipeList from './recipeList/RecipesListPage';

const renderPage = (route, navigator) => (
  <route.component key={route.key} navigator={navigator} title={route.title} hasBackButton={route.hasBackButton}/>
);

const App = () => (
  <Navigator
    renderPage={renderPage}
    initialRoute={{component: RecipeList, key: 'RECIPE_LIST'}}
  />
);

export default App;
