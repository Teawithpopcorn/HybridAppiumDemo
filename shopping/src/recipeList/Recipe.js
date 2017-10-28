import React from 'react';
import PropTypes from "prop-types";
import {ListItem} from 'react-onsenui';

const styles = {
  picture: {
    width: '60px',
    height: '60px'
  },
  content: {
    marginLeft: '8px'
  },
  descriptionContent: {
    marginTop: '8px',
    marginRight: '16px'
  },
  description: {
    fontSize: '12px',
    lineHeight: '1rem',
    color: 'gray'
  }
}

const Recipe = props => {
  const {tapRecipe, name, picture, description} = props
  return (
    <ListItem tappable={true} modifier='chevron' onClick={tapRecipe}>
      <div className='center' style={{flexWrap: 'nowrap'}}>
        <div>
          <img src={picture}  alt="Recipe preview" className='list-item__thumbnail' style={styles.picture} />
        </div>
        <div style={styles.content}>
          <div className='list__item__title'>
            {name}
          </div>
          <div style={styles.descriptionContent}>
            <font style={styles.description}>{description}</font>
          </div>
        </div>
      </div>
    </ListItem>
  );
}

Recipe.propTypes = {
  name: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  picture: PropTypes.string.isRequired,
  tapRecipe: PropTypes.func
}

export default Recipe;
