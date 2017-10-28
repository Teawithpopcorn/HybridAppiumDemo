import React from 'react';
import PropTypes from "prop-types";
import { ListItem } from 'react-onsenui';

const Recipe = props => {
  return (
    <ListItem tappable={true} modifier='chevron' onClick={props.tapRecipe}>
      <div className='left'>
        <img src={props.picture} className='list-item__thumbnail' />
      </div>
      <div className='center'>
        {props.name}
      </div>
    </ListItem>
  );
}

Recipe.propTypes = {
  name: PropTypes.string.isRequired,
  picture: PropTypes.string.isRequired,
  tapRecipe: PropTypes.func
}

export default Recipe;
