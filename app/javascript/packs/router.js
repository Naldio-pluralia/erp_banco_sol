// Import dependencies
import Router from 'vue-router';

// Import views
import Index from '../views/provinces/index';

// Establishments
import IndexEstablishments from '../views/establishments/index';
import NewEstablishment from '../views/establishments/new';
import ShowEstablishment from '../views/establishments/show';
import EditEstablishment from '../views/establishments/edit';

// Organic Units
import IndexOrganicUnits from '../views/organic_units/index';
import NewOrganicUnit from '../views/organic_units/new';
import ShowOrganicUnit from '../views/organic_units/show';
import EditOrganicUnit from '../views/organic_units/edit';

// Create a new router object
const router = new Router({
    routes: [
        { path: '/', name: 'Index',  component: Index },
        { path: '/establishments', name: 'IndexEstablishments',  component: IndexEstablishments },
        { path: '/establishments/new', name: 'NewEstablishment',  component: NewEstablishment },
        { path: '/establishments/show/:id', name: 'ShowEstablishment',  component: ShowEstablishment },
        { path: '/establishments/edit/:id', name: 'EditEstablishment',  component: EditEstablishment },
        { path: '/organic_units', name: 'IndexOrganicUnits',  component: IndexOrganicUnits },
        { path: '/organic_units/new', name: 'NewOrganicUnit',  component: NewOrganicUnit },
        { path: '/organic_units/show/:id', name: 'ShowOrganicUnit',  component: ShowOrganicUnit },
        { path: '/organic_units/edit/:id', name: 'EditOrganicUnit',  component: EditOrganicUnit },
        { path: '*', redirect: '/' },
    ]
});

// Export it to be used in the application.js file
export default router;