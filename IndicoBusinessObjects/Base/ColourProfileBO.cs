// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class ColourProfileBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private string _description;
        private string _name = string.Empty;
        #endregion
        
        #region Foreign Key fields
        #endregion
        
        #region Foreign Table Foreign Key fields
        [NonSerialized][XmlIgnoreAttribute]
        private IndicoList<Indico.BusinessObjects.ProductBO> productsWhereThisIsColourProfileList;
        [NonSerialized][XmlIgnoreAttribute]
        private bool _productsWhereThisIsColourProfileLoaded;
        #endregion
        
        #region Other fields
        
        private Indico.DAL.ColourProfile _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>The description of the Colour Profile. The maximum length of this property is 255.</summary>
        public string Description
        {   
            get {return _description;}
            set 
            {
                OnDescriptionChanging(value);
                _description = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Description = value;
                }
                OnDescriptionChanged();
            }
        }
        /// <summary>The name of the Colour Profile. The maximum length of this property is 64.</summary>
        public string Name
        {   
            get {return _name;}
            set 
            {
                OnNameChanging(value);
                _name = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Name = value;
                }
                OnNameChanged();
            }
        }
        
        internal Indico.DAL.ColourProfile ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        #endregion
        
        #region Foreign Object Foreign Key Collections
        [XmlIgnoreAttribute]
        public IndicoList<Indico.BusinessObjects.ProductBO> ProductsWhereThisIsColourProfile // FK_Product_ColourProfile
        {
            get
            {
                if (!_productsWhereThisIsColourProfileLoaded)
                {
                    _productsWhereThisIsColourProfileLoaded = true;
                    if (this.ID > 0)
                    {
                         IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                        Indico.DAL.ColourProfile obj = (from o in context.ColourProfile
                                     where o.ID == this.ID
                                     select o).FirstOrDefault();

                        obj.ProductsWhereThisIsColourProfile.Load();
                        productsWhereThisIsColourProfileList = new IndicoList<Indico.BusinessObjects.ProductBO>(obj.ProductsWhereThisIsColourProfile.Count);
                        
                        foreach (Indico.DAL.Product o in obj.ProductsWhereThisIsColourProfile)
                        {
                            Indico.BusinessObjects.ProductBO fkObj = new Indico.BusinessObjects.ProductBO(o, ref this._context);
                            productsWhereThisIsColourProfileList.Add(fkObj);
                        }
                        
                        if (this.Context == null)
                        {
                            context.Dispose();
                        }
                    }
                    else
                    {
                        productsWhereThisIsColourProfileList = new IndicoList<Indico.BusinessObjects.ProductBO>();
                    }
                    
                    productsWhereThisIsColourProfileList.OnBeforeRemove += new EventHandler(ProductsWhereThisIsColourProfileList_OnBeforeRemove);
                    productsWhereThisIsColourProfileList.OnAfterAdd += new EventHandler(ProductsWhereThisIsColourProfileList_OnAfterAdd);
                }
                
                return productsWhereThisIsColourProfileList;
            }
        }
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the ColourProfileBO class using the supplied Indico.DAL.ColourProfile. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.ColourProfile whose properties will be used to initialise the ColourProfileBO</param>
        internal ColourProfileBO(Indico.DAL.ColourProfile obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.ColourProfile 
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.ColourProfile SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.ColourProfile properties
            Indico.DAL.ColourProfile obj = new Indico.DAL.ColourProfile();
            
            if (this.ID > 0)
            {
                obj = context.ColourProfile.FirstOrDefault<ColourProfile>(o => o.ID == this.ID);
            }
            
            obj.Description = this.Description;
            obj.Name = this.Name;
            
            
            if (_productsWhereThisIsColourProfileLoaded)
                BusinessObject.SynchroniseEntityList(
                    Indico.BusinessObjects.ProductBO.ToEntityList(this.ProductsWhereThisIsColourProfile, context), 
                    obj.ProductsWhereThisIsColourProfile);
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.ColourProfile))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.ColourProfile obj = (Indico.DAL.ColourProfile)eObj;
            
            // set the Indico.BusinessObjects.ColourProfileBO properties
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.ColourProfileBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.ColourProfileBO properties
            this.ID = obj.ID;
            
            this.Description = obj.Description;
            this.Name = obj.Name;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.ColourProfileBO> IQueryableToList(IQueryable<Indico.DAL.ColourProfile> oQuery)
        {
            List<Indico.DAL.ColourProfile> oList = oQuery.ToList();
            List<Indico.BusinessObjects.ColourProfileBO> rList = new List<Indico.BusinessObjects.ColourProfileBO>(oList.Count);
            foreach (Indico.DAL.ColourProfile o in oList)
            {
                Indico.BusinessObjects.ColourProfileBO obj = new Indico.BusinessObjects.ColourProfileBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.ColourProfileBO> ToList(IEnumerable<Indico.DAL.ColourProfile> oQuery)
        {
            List<Indico.DAL.ColourProfile> oList = oQuery.ToList();
            List<Indico.BusinessObjects.ColourProfileBO> rList = new List<Indico.BusinessObjects.ColourProfileBO>(oList.Count);
            foreach (Indico.DAL.ColourProfile o in oList)
            {
                Indico.BusinessObjects.ColourProfileBO obj = new Indico.BusinessObjects.ColourProfileBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.ColourProfile> ToEntityList(List<ColourProfileBO> bos, IndicoEntities context)
        {
            // build a List of ColourProfile entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.ColourProfile.Count() == 0) ? new List<Indico.DAL.ColourProfile>() : (context.ColourProfile.Where(BuildContainsExpression<ColourProfile, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.ColourProfile>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.ColourProfile> ToEntityCollection(List<ColourProfileBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of ColourProfile entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.ColourProfile> el = (context.ColourProfile.Count() == 0) ? new List<Indico.DAL.ColourProfile>() : 
                context.ColourProfile.Where(BuildContainsExpression<ColourProfile, int>(e => e.ID, ids))
                .ToList<Indico.DAL.ColourProfile>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.ColourProfile> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.ColourProfile>();
                
            foreach (Indico.DAL.ColourProfile r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.ColourProfile ToEntity(IndicoEntities context)
        {
            return (from o in context.ColourProfile
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToColourProfile(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.ColourProfile obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToColourProfile(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.ColourProfile obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.ColourProfile obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.ColourProfileBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.ColourProfileBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.ColourProfile> oQuery =
                        from o in context.ColourProfile
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.ColourProfile> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.ColourProfileBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.ColourProfile> oQuery =
                (from o in context.ColourProfile
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.ColourProfileBO> colourprofiles = IQueryableToList(oQuery);
            context.Dispose();
            return colourprofiles;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.ColourProfileBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.ColourProfile> oQuery =
                (from o in context.ColourProfile
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Description == null || this.Description == o.Description) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.ColourProfileBO> colourprofiles = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return colourprofiles;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.ColourProfile
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Description == null || this.Description == o.Description) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.ColourProfile> oQuery =
                (from o in context.ColourProfile
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Description == null || o.Description.Contains(this.Description)) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.ColourProfileBO> colourprofiles = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return colourprofiles;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.ColourProfile
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Description == null || o.Description.Contains(this.Description)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.ColourProfileBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.ColourProfile> oQuery =
                (from o in context.ColourProfile
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Description.Contains(this.Description)) ||
                    (this.Name == null && this.Description == null ))
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.ColourProfileBO> colourprofiles = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return colourprofiles;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.ColourProfile
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Description.Contains(this.Description)) ||
                    (this.Name == null && this.Description == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.ColourProfileBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.ColourProfileBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.ColourProfileBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.ColourProfileBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.ColourProfileBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.ColourProfileBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnColourProfileBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("ColourProfileBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnColourProfileBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnColourProfileBOIDChanged();
        partial void OnColourProfileBOIDChanging(int value);
        
        partial void OnNameChanged()
        {
            OnColourProfileBONameChanged();
        }
        
        partial void OnNameChanging(string value)
        {
            if (value != null && value.Length > 64)
            {
                throw new Exception(String.Format("ColourProfileBO.Name has a maximum length of 64. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnColourProfileBONameChanging(value);
        }
        partial void OnNameChanged();
        partial void OnNameChanging(string value);
        partial void OnColourProfileBONameChanged();
        partial void OnColourProfileBONameChanging(string value);
        
        partial void OnDescriptionChanged()
        {
            OnColourProfileBODescriptionChanged();
        }
        
        partial void OnDescriptionChanging(string value)
        {
            if (value != null && value.Length > 255)
            {
                throw new Exception(String.Format("ColourProfileBO.Description has a maximum length of 255. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnColourProfileBODescriptionChanging(value);
        }
        partial void OnDescriptionChanged();
        partial void OnDescriptionChanging(string value);
        partial void OnColourProfileBODescriptionChanged();
        partial void OnColourProfileBODescriptionChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.ColourProfileBO))
                return 1;
            Indico.BusinessObjects.ColourProfileBOComparer c = new Indico.BusinessObjects.ColourProfileBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.ColourProfileBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.ColourProfile)sender);
            }
        }
        
        void ProductsWhereThisIsColourProfileList_OnAfterAdd(object sender, EventArgs e)
        {
            Indico.DAL.Product obj = null;
            if (this.Context != null)
            {
                if (((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count > 0)
                {
                    obj = ((IndicoList<Indico.BusinessObjects.ProductBO>)sender)[((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count - 1].ObjDAL;
                    this.ObjDAL.ProductsWhereThisIsColourProfile.Add(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                obj = ((IndicoList<Indico.BusinessObjects.ProductBO>)sender)[((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count - 1].SetDAL(objContext.Context);
                this.ObjDAL.ProductsWhereThisIsColourProfile.Add(obj);
                objContext.SaveChanges();
                objContext.Dispose();
            }
        }
        
        void ProductsWhereThisIsColourProfileList_OnBeforeRemove(object sender, EventArgs e)
        {
            Indico.DAL.Product obj = null;
            if (this.Context != null)
            {
                if (((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count > 0)
                {
                    obj = ((IndicoList<Indico.BusinessObjects.ProductBO>)sender)[((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count - 1].ObjDAL;
                    this.ObjDAL.ProductsWhereThisIsColourProfile.Remove(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                obj = ((IndicoList<Indico.BusinessObjects.ProductBO>)sender)[((IndicoList<Indico.BusinessObjects.ProductBO>)sender).Count - 1].SetDAL(objContext.Context);
                this.ObjDAL.ProductsWhereThisIsColourProfile.Remove(obj);
                objContext.SaveChanges();
                objContext.Dispose();
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
            this._productsWhereThisIsColourProfileLoaded = false;
            if (this.productsWhereThisIsColourProfileList != null)
            {
                this.productsWhereThisIsColourProfileList.OnBeforeRemove -= new EventHandler(ProductsWhereThisIsColourProfileList_OnBeforeRemove);
                this.productsWhereThisIsColourProfileList.OnAfterAdd -= new EventHandler(ProductsWhereThisIsColourProfileList_OnAfterAdd);
            }
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region ColourProfileBOComparer
    public class ColourProfileBOComparer : IComparer<Indico.BusinessObjects.ColourProfileBO>
    {
        private string propertyToCompareName;
        public ColourProfileBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.ColourProfileBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.ColourProfileBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public ColourProfileBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.ColourProfileBO> Members
        public int Compare(Indico.BusinessObjects.ColourProfileBO x, Indico.BusinessObjects.ColourProfileBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.ColourProfileBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.ColourProfileBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.ColourProfileBO x, Indico.BusinessObjects.ColourProfileBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
