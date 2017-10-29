import React, {Component} from 'react';
import _ from 'lodash';
import {
  Page,
  Button,
  Toast
} from 'react-onsenui';
import NavBar from '../shared/NavBar';
import './RecipeDetailPage.css';

const ComboType = {
  One: 0,
  Two: 1
}

const ComboFlavor = {
  ABitOFHot: 0,
  Hot: 1,
  VeryHot: 2
}

export default class GoodsDetailPage extends Component {
  constructor(props) {
    super(props)
    this.state = {
      combo: null,
      flavor: null,
      error: null
    }
  }

  onDismissError() {
    this.setState({error: null})
  }

  onSubmitOrder() {
    const { combo, flavor } = this.state;
    const { navigator } = this.props;
    let error = null;

    if (combo === null) {
      error = '请选择套餐';
    }

    if(combo === ComboType.One && flavor === null ) {
      error = '请选择口味';
    }

    this.setState({error});

    setTimeout(() => {
      if (_.isEmpty(error)) {
        navigator.popPage()
      }
    }, 1000)
  }

  renderComboButton(name, type) {
    const {combo} = this.state;
    const tapCombo = () => {
      const nextComboType = combo !== type ? type : null
      this.setState({
        combo: nextComboType,
        error: null,
        flavor: null
      })
    };

    return (
      <Button
        className='Detail-combo-button'
        modifier={combo === type ? undefined : 'outline'}
        onClick={tapCombo}
      >
        {name}
      </Button>
    );
  }

  renderFlavorButton(name, type) {
    const {flavor} = this.state;
    const tapFlavor = () => {
      const nextFlavorType = flavor !== type ? type : null
      this.setState({
        error: null,
        flavor: nextFlavorType
      })
    }

    return (
      <Button
        className='Detail-combo-button'
        modifier={flavor === type ? undefined : 'outline'}
        onClick={tapFlavor}
      >
        {name}
      </Button>
    )
  }

  render() {
    const {navigator, title, hasBackButton} = this.props;
    const {combo, error} = this.state;

    return (
      <Page renderToolbar={() => <NavBar title={title} backButton={hasBackButton} navigator={navigator} />}>
        <div className='Detail-container'>
          <div>
            <img src='https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1463425548,1258189658&fm=27&gp=0.jpg' alt='detail' />
          </div>
          <p> 炸酱面是中国传统特色面食。最初起源北京，为山东鲁菜。不过在传遍大江南北之后便被誉为“中国十大面条”之一 </p>
          <hr />
          <div className='Detail-combo'>
            {this.renderComboButton('套餐一', ComboType.One)}
            {this.renderComboButton('套餐二', ComboType.Two)}
          </div>
          <hr />
          <div className='Detail-flavor' hidden={combo !== ComboType.One}>
            {this.renderFlavorButton('微辣', ComboFlavor.ABitOFHot)}
            {this.renderFlavorButton('中辣', ComboFlavor.Hot)}
            {this.renderFlavorButton('变态辣', ComboFlavor.VeryHot)}
          </div>
          <hr />
          <Button modifier='large' fipple onClick={this.onSubmitOrder.bind(this)}>立即购买</Button>
        </div>

        <Toast isOpen={!_.isEmpty(error)}>
          <div className="message">
            {error}
          </div>
          <button onClick={this.onDismissError.bind(this)}>
            取消
          </button>
        </Toast>
      </Page>
    )
  }
}
