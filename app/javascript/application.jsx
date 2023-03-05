import { render } from 'solid-js/web';
import CatList from './components/cats/CatList';

render(() => <CatList serviceType={'poro'} />, document.getElementById('app'))
