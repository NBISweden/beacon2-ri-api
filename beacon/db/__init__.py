from pymongo.mongo_client import MongoClient
from beacon import conf


uri = "mongodb://{}:{}@{}:{}/{}?authSource={}".format(
    conf.database_user,
    conf.database_password,
    conf.database_host,
    conf.database_port,
    conf.database_name,
    conf.database_auth_source
)

if conf.database_certificate:
    uri += '&tls=true&tlsCertificateKeyFile={}'.format(conf.database_certificate)
    if conf.database_cafile:
        uri += '&tlsCAFile={}'.format(conf.database_cafile)

client = MongoClient(uri)
