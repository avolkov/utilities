##Use do acquire admin security privileges

## An implementation from
# http://stackoverflow.com/questions/9683466/purging-all-old-cmfeditions-versions
from AccessControl.SecurityManagement import newSecurityManager
from Products.CMFCore.utils import getToolByName
from Products.CMFPlone.Portal import PloneSite
from zope.app.component.hooks import setSite
from Products.CMFEditions.utilities import dereference

import transaction
from DateTime import DateTime

sites = {}

for child_node in app.getChildNodes():
    # Find all plone sites hosted on this db
    if isinstance(child_node, PloneSite):
        sites[child_node.__name__] = child_node

print "Found sites in the db(sites): %s" % ", ".join(sites.keys())

for site in sites.values():
    setSite(site)
    admin=app.acl_users.getUserById("portaladmin")
    newSecurityManager(None, admin)
    policy = getToolByName(site, 'portal_purgepolicy')
    catalog = getToolByName(site, 'portal_catalog')
    for count, brain in enumerate(catalog()):
        obj = brain.getObject()
        # only purge old content
        if obj.created() < (DateTime() - 30):
            obj, history_id = dereference(obj)
            policy.beforeSaveHook(history_id, obj)
            print 'purged object ' + obj.absolute_url_path()

transaction.commit()
